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
    //上拉刷新和下拉刷新是否添加 && 以及添加上拉和下拉的监听
    if (self.showAllReflesh) {
        NSParameterAssert(self.pullUpView);
        NSParameterAssert(self.pullDownView);
        [self hsy_observePullDown];
        [self hsy_observePullUp];
    } else {
        if (self.showPullDown) {
            NSParameterAssert(self.pullDownView);
            [self hsy_observePullDown];
        }
        if (self.showPullUp) {
            NSParameterAssert(self.pullUpView);
            [self hsy_observePullUp];
        }
    }
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

#pragma mark - Observer

- (void)hsy_observePullDown
{
    @weakify(self);
    [[RACObserve(self, self.hsy_viewModel.hsy_pullDownStateCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听下拉刷新
        @strongify(self);
        if ([self hsy_requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeRequestPullDownSuccess) {
            //监听到statusCode下拉状态变更后，发送一个信后，让table格式或者collection格式的两个子类进行reloadData动作
            [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess subscribeContents:@[x]];
        }
    }];
}

- (void)hsy_observePullUp
{
    @weakify(self);
    [[RACObserve(self, self.hsy_viewModel.hsy_pullUpStateCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听上拉刷新
        @strongify(self);
        if ([self hsy_requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeRequestPullUpSuccess) {
            //监听到statusCode上拉状态变更后，发送一个信后，让table格式或者collection格式的两个子类进行reloadData动作
            [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess subscribeContents:@[x]];
        }
    }];
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
    @weakify(scrollView);
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(scrollView);
        @strongify(self);
        kHSYCocoaKitRACSubjectOfNextType type = (pullDown ? kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess : kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess);
        if (type == kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess) {
            [scrollView.pullToRefreshView stopAnimating];
            [self hsy_hasMorePullUp:scrollView];
            [self hsy_openPullUp:scrollView];
        } else {
            [scrollView.infiniteScrollingView stopAnimating];
        }
    });
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
