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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *param = @{};
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
}

@end
