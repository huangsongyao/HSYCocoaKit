//
//  HSYBaseRefleshViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "HSYBaseRefleshViewController.h"
#import "HSYHUDModel.h"
#import "PublicMacroFile.h"

NSString *const kHSYCocoaKitRefreshPullDownStatusKey = @"HSYCocoaKitRefreshPullDownStatusKey";
NSString *const kHSYCocoaKitRefreshStatusPullUpKey = @"HSYCocoaKitRefreshStatusPullUpKey";

@interface HSYBaseRefleshViewController ()

@end

@implementation HSYBaseRefleshViewController

- (instancetype)init
{
    if (self = [super init]) {
        _showAllReflesh = NO;
        _showPullDown = NO;
        _showPullUp = NO;
        _pullUpStatus = kHSYCocoaKitRefreshForPullUpCompletedStatusClose;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //非自定义的navigationBar模式下，在“- viewWillAppear:”，通过将系统的navigationBar设置到navigationController所有子视图的最底层来掩盖
    if (!self.customNavigationBar && self.hsy_sendNavigationBarToBack) {
        [self.navigationController.view sendSubviewToBack:self.navigationController.navigationBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //非自定义的navigationBar模式下，在“- viewWillDisappear:”，通过将系统的navigationBar设置到它原来在navigationController中的原始位置
    if (!self.customNavigationBar && self.hsy_sendNavigationBarToBack) {
        [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
    }
}

#pragma mark - Set Pull Down && Pull Up

- (void)hsy_addRefresh:(UIScrollView *)scrollView
{
    [self hsy_addPullUpRefresh:scrollView];
    [self hsy_addPullDownRefresh:scrollView];
}

- (void)hsy_addPullDownRefresh:(UIScrollView *)scrollView
{
    NSParameterAssert(scrollView);
    @weakify(self);
    @weakify(scrollView);
    [scrollView addPullToRefreshWithLoadingView:self.pullDownView subscribeActionHandler:^{
        @strongify(self);
        @strongify(scrollView);
        [self hsy_refreshResult:scrollView isPullDown:YES];
    }];
}

- (void)hsy_addPullUpRefresh:(UIScrollView *)scrollView
{
    NSParameterAssert(scrollView);
    @weakify(self);
    @weakify(scrollView);
    [scrollView addInfiniteScrollingWithLoadingView:self.pullUpView subscribeActionHandler:^{
        @strongify(self);
        @strongify(scrollView);
        [self hsy_refreshResult:scrollView isPullDown:NO];
    }];
}

- (void)hsy_refreshResult:(UIScrollView *)scrollView isPullDown:(BOOL)pullDown
{
    @weakify(self);
    @weakify(scrollView);
    RACSignal *signal = [self.hsy_viewModel hsy_rac_pullUpMethod];
    if (pullDown) {
        signal = [self.hsy_viewModel hsy_rac_pullDownMethod];
    }
    [[signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeCompleted:^{
        @strongify(self);
        @strongify(scrollView);
        [self subjectSendNext:pullDown refreshScrollView:scrollView];
    }];
}

- (void)subjectSendNext:(BOOL)pullDown refreshScrollView:(UIScrollView *)scrollView
{
    if (self.hsy_refreshRequestSuccess) {
        @weakify(self);
        kHSYCocoaKitRACSubjectOfNextType type = (pullDown ? kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess : kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess);
        HSYCocoaKitRACSubscribeNotification *notification = [self.hsy_viewModel hsy_defaultSubscribeNotification:type subscribeContents:@[self.hsy_viewModel.hsy_refreshStateCode]];
        [[self.hsy_refreshRequestSuccess(pullDown, notification) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
            @strongify(self);
            UIView *refreshDown = scrollView.pullToRefreshView;
            UIView *refreshUp = scrollView.infiniteScrollingView;
            NSMutableDictionary *stopSelector = [[NSMutableDictionary alloc] init];
            if (refreshUp) {
                stopSelector[@(kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess)] = refreshUp;
            }
            if (refreshDown) {
                stopSelector[@(kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess)] = refreshDown;
            }
            [stopSelector[@(type)] performSelector:@selector(stopAnimating)];
            [self hsy_openPullUp:scrollView];
            if (self.showAllReflesh || self.showPullUp) {
                BOOL hasDatas = (self.hsy_viewModel.hsy_datas.count > 0 && self.hsy_viewModel.hsy_datas.count % self.hsy_viewModel.size == 0);
                NSDictionary *selector = @{@(NO) : @{@(kHSYCocoaKitRefreshForPullUpCompletedStatusClose) : @[NSStringFromSelector(@selector(hsy_closePullUp:))], @(kHSYCocoaKitRefreshForPullUpCompletedStatusNorMore) : @[NSStringFromSelector(@selector(hsy_notMorePullUp:))], }, @(YES) : @{@(kHSYCocoaKitRefreshForPullUpCompletedStatusClose) : @[NSStringFromSelector(@selector(hsy_hasMorePullUp:))], @(kHSYCocoaKitRefreshForPullUpCompletedStatusNorMore) : @[NSStringFromSelector(@selector(hsy_hasMorePullUp:))], },
                                           }[@(hasDatas)];
                NSArray *selectors = selector[@(self.pullUpStatus)];
                for (NSString *sel in selectors) {
                    HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(
                        [self performSelector:NSSelectorFromString(sel) withObject:scrollView]
                    );
                }
            }
        }];
    }
}

#pragma mark - Close Or Open

- (void)hsy_closePullUp:(UIScrollView *)scrollView
{
    if (self.showPullUp || self.showAllReflesh) {
        scrollView.showsInfiniteScrolling = NO;
    }
}

- (void)hsy_notMorePullUp:(UIScrollView *)scrollView
{
    if (self.showPullUp || self.showAllReflesh) {
        scrollView.showsNoMoreDataView = YES;
    }
}

- (void)hsy_hasMorePullUp:(UIScrollView *)scrollView
{
    if (self.showPullUp || self.showAllReflesh) {
        scrollView.showsNoMoreDataView = NO;
    }
}

- (void)hsy_openPullUp:(UIScrollView *)scrollView
{
    if (self.showPullUp || self.showAllReflesh) {
        scrollView.showsInfiniteScrolling = YES;
    }
}

@end
