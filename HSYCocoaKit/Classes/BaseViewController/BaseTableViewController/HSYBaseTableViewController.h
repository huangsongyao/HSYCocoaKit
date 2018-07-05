//
//  HSYBaseTableViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshViewController.h"

@interface HSYBaseTableViewController : HSYBaseRefleshViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) UITableViewStyle tableViewStyle;                      //列表模式，默认UITableViewStylePlain模式
@property (nonatomic, strong) NSNumber *lineHidden;                                 //是否隐藏系统分割线，默认不隐藏
@property (nonatomic, strong) NSNumber *scrollEnabled;                              //是否允许滚动，默认YES
@property (nonatomic, strong, readonly) UITableView *tableView;

//格式：@{@"类名" : @"重用标识",}
@property (nonatomic, strong, readwrite) NSDictionary<NSString *, NSString *> *registerClasses;

/**
 "UITableView+FDTemplateLayoutCell.h"库的“- hsy_heightForCellWithIdentifier:cacheByIndexPath:configuration:”方法

 @param indexPath 重用位置
 @param configuration set内容的回调
 @return cell算高
 */
- (CGFloat)hsy_heightForCellWithCacheByIndexPath:(NSIndexPath *)indexPath
                                   configuration:(void(^)(UITableViewCell *cell))configuration;

- (void)firstRequest;

@end
