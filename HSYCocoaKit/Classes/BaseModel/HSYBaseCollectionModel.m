//
//  HSYBaseCollectionModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseCollectionModel.h"

@implementation HSYBaseCollectionModel

- (void)hsy_refreshToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self hsy_updateNext:network toMap:map pullDown:kHSYReflesStatusTypePullUp];
}

- (void)hsy_refreshToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self hsy_updateNext:network toMap:map pullDown:kHSYReflesStatusTypePullDown];
}

@end
