//
//  HSYBaseTableViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface HSYBaseTableViewController : HSYBaseRefleshViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, strong) NSNumber *lineHidden;
@property (nonatomic, strong) NSNumber *scrollEnabled;
@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, copy) void(^didSelectRowAtIndexPath)(NSIndexPath *indexPath, id object);

//格式：@[@{@"类名" : @"重用标识",}, @{@"类名" : @"重用标识",}....]
@property (nonatomic, strong, readwrite) NSArray<NSDictionary *> *registerClasses;

@end
