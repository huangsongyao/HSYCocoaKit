//
//  HSYBaseTableModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseTableModel.h"
#import "PublicMacroFile.h"

@implementation HSYBaseTableModel

- (void)hsy_refreshToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void(^)(id x, NSError *error))next
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullDown updateNext:network toMap:map subscriberNext:next];
}

- (void)hsy_refreshToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map subscriberNext:(void(^)(id x, NSError *error))next
{
    [self hsy_pullRefresh:kHSYReflesStatusTypePullUp updateNext:network toMap:map subscriberNext:next];
}

- (RACSignal *)hsy_refreshTableToPullDown:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_refreshToPullDown:network toMap:map subscriberNext:^(id x, NSError *error) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- (RACSignal *)hsy_refreshTableToPullDown:toMap:”");
        }];
    }];
}

- (RACSignal *)hsy_refreshTableToPullUp:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self hsy_refreshToPullUp:network toMap:map subscriberNext:^(id x, NSError *error) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- (RACSignal *)hsy_refreshTableToPullUp:toMap:”");
        }];
    }];
}

- (RACSignal *)hsy_refreshTable:(kHSYReflesStatusType)type requestNetwork:(RACSignal *(^)(void))network toMap:(NSMutableArray *(^)(RACTuple *tuple))map
{
    if (type == kHSYReflesStatusTypePullUp) {
        return [self hsy_refreshTableToPullUp:network toMap:map];
    } else {
        return [self hsy_refreshTableToPullDown:network toMap:map];
    }
}

@end
