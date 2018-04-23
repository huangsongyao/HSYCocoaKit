//
//  HSYBaseTableModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseTableModel.h"

@implementation HSYBaseTableModel

- (void)hsy_refreshToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullUp updateNext:network toMap:map];
}

- (void)hsy_refreshToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullDown updateNext:network toMap:map];
}

@end
