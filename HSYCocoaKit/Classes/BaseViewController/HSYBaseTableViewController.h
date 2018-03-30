//
//  HSYBaseTableViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshViewController.h"

@interface HSYBaseTableViewController : HSYBaseRefleshViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readonly) UITableView *tableView;

@end
