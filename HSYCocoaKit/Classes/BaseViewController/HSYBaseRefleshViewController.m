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
        [self observePullDown];
        [self observePullUp];
    } else {
        if (self.showPullDown) {
            NSParameterAssert(self.pullDownView);
            [self observePullDown];
        }
        if (self.showPullUp) {
            NSParameterAssert(self.pullUpView);
            [self observePullUp];
        }
    }
}

- (void)observePullDown
{
    @weakify(self);
    [[RACObserve(self, self.viewModel.pullDownStateCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听下拉刷新
        @strongify(self);
        if ([self requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeRequestPullDownSuccess) {
            //监听到statusCode下拉状态变更后，发送一个信后，让table格式或者collection格式的两个子类进行reloadData动作
            [self.viewModel.subject sendNext:@{@(kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess) : x}];
        }
    }];
}

- (void)observePullUp
{
    @weakify(self);
    [[RACObserve(self, self.viewModel.pullUpStateCode) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        //监听上拉刷新
        @strongify(self);
        if ([self requestStateCodeWithStateCode:x] == kHSYHUDModelCodeTypeRequestPullUpSuccess) {
            //监听到statusCode上拉状态变更后，发送一个信后，让table格式或者collection格式的两个子类进行reloadData动作
            [self.viewModel.subject sendNext:@{@(kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess) : x}];
        }
    }];
}

#pragma mark - Set Pull Down && Pull Up

- (void)addRefresh:(UIScrollView *)scrollView
{
    [self addPullUpRefresh:scrollView];
    [self addPullDownRefresh:scrollView];
}

- (void)addPullDownRefresh:(UIScrollView *)scrollView
{
    NSParameterAssert(scrollView);
    @weakify(self);
    [scrollView addPullToRefreshWithLoadingView:self.pullDownView subscribeActionHandler:^{
        @strongify(self);
        [self.viewModel.subject sendNext:@{@(kHSYCocoaKitRACSubjectOfNextTypePerformPullDown) : kHSYCocoaKitRefreshPullDownStatusKey}];
    }];
}

- (void)addPullUpRefresh:(UIScrollView *)scrollView
{
    NSParameterAssert(scrollView);
    @weakify(self);
    [scrollView addInfiniteScrollingWithLoadingView:self.pullUpView subscribeActionHandler:^{
        @strongify(self);
        [self.viewModel.subject sendNext:@{@(kHSYCocoaKitRACSubjectOfNextTypePerformPullUp) : kHSYCocoaKitRefreshStatusPullUpKey}];
    }];
}

@end
