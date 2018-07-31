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

- (void)hsy_refreshCollectionToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self hsy_refreshToPullDown:network toMap:map subscriberNext:^(id x) {
        NSLog(@"refresh To Down Result : %@", x);
    }];
}

- (void)hsy_refreshCollectionToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    [self hsy_refreshToPullUp:network toMap:map subscriberNext:^(id x) {
        NSLog(@"refresh To Down Result : %@", x);
    }];
}

- (void)hsy_refreshCollection:(kHSYReflesStatusType)type requestNetwork:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    if (type == kHSYReflesStatusTypePullUp) {
        [self hsy_refreshCollectionToPullUp:network toMap:map];
    } else {
        [self hsy_refreshCollectionToPullDown:network toMap:map];
    }
}

@end
