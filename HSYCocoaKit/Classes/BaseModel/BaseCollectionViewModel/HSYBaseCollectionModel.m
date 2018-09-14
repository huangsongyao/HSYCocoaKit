//
//  HSYBaseCollectionModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseCollectionModel.h"

@implementation HSYBaseCollectionModel

- (void)hsy_refreshToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void (^)(id, NSError *error))next
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullUp updateNext:network toMap:map subscriberNext:next];
}

- (void)hsy_refreshToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void (^)(id, NSError *error))next
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullDown updateNext:network toMap:map subscriberNext:next];
}

- (RACSignal *)hsy_refreshCollectionToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_refreshToPullDown:network toMap:map subscriberNext:^(id x, NSError *error) {
            [subscriber sendNext:RACTuplePack(x, error)];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- (RACSignal *)hsy_refreshTableToPullDown:toMap:”");
        }];
    }];
}

- (RACSignal *)hsy_refreshCollectionToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_refreshToPullDown:network toMap:map subscriberNext:^(id x, NSError *error) {
            [subscriber sendNext:RACTuplePack(x, error)];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- (RACSignal *)hsy_refreshCollectionToPullUp:toMap:”");
        }];
    }];
}

- (RACSignal *)hsy_refreshCollection:(kHSYReflesStatusType)type requestNetwork:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    if (type == kHSYReflesStatusTypePullUp) {
        return [self hsy_refreshCollectionToPullUp:network toMap:map];
    } else {
        return [self hsy_refreshCollectionToPullDown:network toMap:map];
    }
}


@end
