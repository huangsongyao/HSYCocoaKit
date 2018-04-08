//
//  HSYBaseTableViewController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseTableViewController.h"
#import "NSObject+UIKit.h"

@interface HSYBaseTableViewController ()

@end

@implementation HSYBaseTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        _lineHidden = @(NO);
        _scrollEnabled = @(YES);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //生成默认的tableView
    NSMutableDictionary *param = [@{
                                    @(kHSYCocoaKitOfTableViewPropretyTypeTableViewStyle) : @(UITableViewStylePlain),
                                    @(kHSYCocoaKitOfTableViewPropretyTypeFrame) : [NSValue valueWithCGRect:self.view.bounds],
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
        [self addRefresh:self.tableView];
    } else {
        if (self.showPullUp) {
            [self addPullUpRefresh:self.tableView];
        }
        if (self.showPullDown) {
            [self addPullDownRefresh:self.tableView];
        }
    }
    
    //监听上下拉刷新
    @weakify(self);
    [self.viewModel.subject subscribeNext:^(NSDictionary *signal) {
        @strongify(self);
        kHSYCocoaKitRACSubjectOfNextType type = (kHSYCocoaKitRACSubjectOfNextType)[signal.allKeys.firstObject integerValue];
        if (type == kHSYCocoaKitRACSubjectOfNextTypePullDownSuccess || type == kHSYCocoaKitRACSubjectOfNextTypePullUpSuccess) {
            //下拉刷新成功//上拉加载更多成功
            [self.tableView reloadData];
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
    [self.viewModel.subject sendNext:@{@(kHSYCocoaKitRACSubjectOfNextTypeTableViewDidSelectRow) : indexPath}];
}

@end
