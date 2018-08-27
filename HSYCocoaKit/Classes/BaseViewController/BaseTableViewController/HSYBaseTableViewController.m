//
//  HSYBaseTableViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseTableViewController.h"
#import "NSObject+UIKit.h"
#import "HSYBaseTableModel.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface HSYBaseTableViewController ()

@end

@implementation HSYBaseTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        _lineHidden = @(NO);
        _scrollEnabled = @(YES);
        _tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect rect = self.view.bounds;
    if (self.customNavigationBar) {
        rect = CGRectMake(0, self.customNavigationBar.bottom, self.view.width, self.view.height - self.customNavigationBar.bottom);
    }
    //生成默认的tableView
    NSMutableDictionary *param = [@{
                                    @(kHSYCocoaKitOfTableViewPropretyTypeTableViewStyle) : @(self.tableViewStyle),
                                    @(kHSYCocoaKitOfTableViewPropretyTypeFrame) : [NSValue valueWithCGRect:rect],
                                    @(kHSYCocoaKitOfTableViewPropretyTypeDelegate) : self,
                                    @(kHSYCocoaKitOfTableViewPropretyTypeDataSource) : self,
                                    @(kHSYCocoaKitOfTableViewPropretyTypeHiddenCellLine) : self.lineHidden,
                                    @(kHSYCocoaKitOfTableViewPropretyTypeScrollEnabled) : self.scrollEnabled,
                                    } mutableCopy];
    if (self.registerClasses.count > 0) {
        param[@(kHSYCocoaKitOfTableViewPropretyTypeRegisterClass)] = self.registerClasses;
    }
    _tableView = [NSObject createTabelViewByParam:param];
    [self.view addSubview:self.tableView];
    
    //添加上下拉
    if (self.showAllReflesh) {
        [self hsy_addRefresh:self.tableView];
    } else {
        if (self.showPullUp) {
            [self hsy_addPullUpRefresh:self.tableView];
        }
        if (self.showPullDown) {
            [self hsy_addPullDownRefresh:self.tableView];
        }
    }
    
    //监听上下拉刷新
    @weakify(self);
    [self.hsy_viewModel.subject subscribeNext:^(HSYCocoaKitRACSubscribeNotification *signal) {
        @strongify(self);
        if (self.hsy_refreshResult) {
            RACSignal *refreshSignal = self.hsy_refreshResult(signal);
            [[refreshSignal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitRACSubscribeNotification *notification) {
                if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess ||
                    notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess) {
                    if (self.hsy_viewModel.hsy_isFirstTimes) {
                        self.hsy_viewModel.hsy_isFirstTimes = !self.hsy_viewModel.hsy_isFirstTimes;
                    }
                    if (notification.subscribeType == kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess && [notification.subscribeContents.firstObject isKindOfClass:[HSYHUDModel class]]) {
                        HSYHUDModel *hudModel = notification.subscribeContents.firstObject;
                        if (hudModel.pullUpSize < self.hsy_viewModel.size) {
                            if (self.pullUpStatus == kHSYCocoaKitRefreshForPullUpCompletedStatusClose) {
                                [self hsy_closePullUp:self.tableView];
                            } else {
                                [self hsy_notMorePullUp:self.tableView];
                            }
                        }
                    }
                    //下拉刷新成功//上拉加载更多成功
                    [self.tableView reloadData];
                }
            }];
        }
    }];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.hsy_viewModel hsy_sendNext:kHSYCocoaKitRACSubjectOfNextTypeTableViewDidSelectRow subscribeContents:@[indexPath]];
}

- (CGFloat)hsy_heightForCellWithCacheByIndexPath:(NSIndexPath *)indexPath configuration:(void(^)(UITableViewCell *cell))configuration
{
    return [self.tableView fd_heightForCellWithIdentifier:self.registerClasses.allValues.firstObject
                                         cacheByIndexPath:indexPath
                                            configuration:configuration];;
}

#pragma mark - First Request

- (void)firstRequest
{
    self.hsy_viewModel.hsy_isFirstTimes = YES;
    [self.tableView.pullToRefreshView startAnimating];
    [self hsy_closePullUp:self.tableView];
}

@end
