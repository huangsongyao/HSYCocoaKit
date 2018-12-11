//
//  UITableView+Operation.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/12/11.
//

#import "UITableView+Operation.h"

@implementation UITableView (Operation)

- (void)hsy_insertObjectInFirstSectionRow
{
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self insertRowsAtIndexPaths:@[firstIndexPath] withRowAnimation:UITableViewRowAnimationTop];
}

- (void)hsy_deleteObjectInFirstSectionRow
{
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self deleteRowsAtIndexPaths:@[firstIndexPath] withRowAnimation:UITableViewRowAnimationTop];
}


@end
