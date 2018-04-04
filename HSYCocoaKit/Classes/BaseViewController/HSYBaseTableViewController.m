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
    if (self.didSelectRowAtIndexPath) {
        self.didSelectRowAtIndexPath(indexPath, nil);
    }
}

@end
