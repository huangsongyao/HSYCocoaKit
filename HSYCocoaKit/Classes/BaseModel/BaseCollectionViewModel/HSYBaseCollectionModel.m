//
//  HSYBaseCollectionModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseCollectionModel.h"

@implementation HSYBaseCollectionModel

- (void)hsy_refreshToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void (^)(id))next
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullUp updateNext:network toMap:map subscriberNext:next];
}

- (void)hsy_refreshToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void (^)(id))next
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullDown updateNext:network toMap:map subscriberNext:next];
}

- (void)hsy_refreshToPullDown:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void(^)(id x))next
{
    @weakify(self);
    [self hsy_refreshToPullDown:^RACSignal *{
        @strongify(self);
        return [self hsy_rac_pullDownMethod];
    } toMap:map subscriberNext:next];
}

- (void)hsy_refreshToPullUp:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void(^)(id x))next
{
    @weakify(self);
    [self hsy_refreshToPullUp:^RACSignal *{
        @strongify(self);
        return [self hsy_rac_pullUpMethod];
    } toMap:map subscriberNext:next];
}

@end
