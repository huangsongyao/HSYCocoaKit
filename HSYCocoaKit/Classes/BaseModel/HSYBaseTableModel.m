//
//  HSYBaseTableModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseTableModel.h"

@implementation HSYBaseTableModel

- (void)refreshToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self updateNext:network toMap:map pullDown:kHSYReflesStatusTypePullUp];
}

- (void)refreshToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self updateNext:network toMap:map pullDown:kHSYReflesStatusTypePullDown];
}

@end
