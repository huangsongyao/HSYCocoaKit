//
//  UITableView+Operation.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Operation)

/**
 在Section=0和Row=0处插入
 */
- (void)hsy_insertObjectInFirstSectionRow;

/**
 在Section=0和Row=0处删除
 */
- (void)hsy_deleteObjectInFirstSectionRow;

@end

NS_ASSUME_NONNULL_END
