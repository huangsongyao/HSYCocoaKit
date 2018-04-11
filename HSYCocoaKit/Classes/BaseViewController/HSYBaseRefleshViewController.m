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

- (void)hsy_observePullDown
{
    @weakify(self);
    [[RACObserve(self, self.hsy_viewModel.hsy_pullDownStateCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听下拉刷新
        @strongify(self);
        if ([self hsy_requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeRequestPullDownSuccess) {
            //监听到statusCode下拉状态变更后，发送一个信后，让table格式或者collection格式的两个子类进行reloadData动作
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess subscribeContents:@[x]];
            [self.hsy_viewModel.subject sendNext:object];
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
            HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess subscribeContents:@[x]];
            [self.hsy_viewModel.subject sendNext:object];
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
    [scrollView addPullToRefreshWithLoadingView:self.pullDownView subscribeActionHandler:^{
        @strongify(self);
        HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypePerformPullDown subscribeContents:@[kHSYCocoaKitRefreshPullDownStatusKey]];
        [self.hsy_viewModel.subject sendNext:object];
    }];
}

- (void)hsy_addPullUpRefresh:(UIScrollView *)scrollView
{
    NSParameterAssert(scrollView);
    @weakify(self);
    [scrollView addInfiniteScrollingWithLoadingView:self.pullUpView subscribeActionHandler:^{
        @strongify(self);
        HSYCocoaKitRACSubscribeNotification *object = [[HSYCocoaKitRACSubscribeNotification alloc] initWithSubscribeNotificationType:kHSYCocoaKitRACSubjectOfNextTypePerformPullUp subscribeContents:@[kHSYCocoaKitRefreshStatusPullUpKey]];
        [self.hsy_viewModel.subject sendNext:object];
    }];
}

@end
