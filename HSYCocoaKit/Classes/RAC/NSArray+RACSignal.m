//
//  NSArray+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "NSArray+RACSignal.h"

@implementation NSArray (RACSignal)

- (RACSignal *)rac_traverseArray {
    
    if (self.count == 0) {
        return nil;
    }
    static NSInteger index = -1;
    
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        if (self.count == 0) {
            
            [subscriber sendCompleted];
        } else {
            @strongify(self);
            [[self.rac_sequence.signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
                
                ++ index;
                [subscriber sendNext:@{
                                       @(index) : x,
                                       }];
                
            } completed:^{
                [subscriber sendCompleted];
                index = -1;
            }];
        }
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}

- (void)rac_filterUntilCompleted:(BOOL(^)(id predicate))completed toMap:(id(^)(id value))map subscribeNext:(void(^)(id x))next overFilter:(void(^)())over
{
    [[[[self.rac_sequence filter:^BOOL(id value) {
        if (completed) {
            return completed(value);
        }
        return YES;
    }] map:^id(id value) {
        if (map) {
            return map(value);
        }
        return value;
    }].signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        if (next) {
            next(x);
        }
    } completed:^{
        if (over) {
            over();
        }
    }];
}

- (void)rac_filterUntilCompleted:(BOOL(^)(id predicate))completed toMap:(id(^)(id value))map subscribeNext:(void(^)(id x))next
{
    [self rac_filterUntilCompleted:completed toMap:map subscribeNext:next overFilter:^{
        
    }];
}

- (RACSignal *)rac_filterUntilCompleted:(BOOL(^)(id predicate))completed toMap:(id(^)(id value))map
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self rac_filterUntilCompleted:completed toMap:map subscribeNext:^(id x) {
            [subscriber sendNext:x];
        } overFilter:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
        }];
    }];
}

- (RACSignal *)rac_filterUntilCompleted:(BOOL(^)(id predicate))completed
{
    return [self rac_filterUntilCompleted:completed toMap:^id(id value) {
        return value;
    }];
}

@end
