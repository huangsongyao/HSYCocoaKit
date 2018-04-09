//
//  NSDictionary+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import "NSDictionary+RACSignal.h"

@implementation NSDictionary (RACSignal)

- (RACSignal *)rac_traverseDictionary
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        [self rac_traverseDictionaryForSubscribeNext:^(id key, id value) {
            
            [subscriber sendNext:@{
                                   key : value,
                                   }];
            
        } traverseCompleted:^{
            
            [subscriber sendCompleted];
            
        }];
        
        return nil;
    }];
}

- (void)rac_traverseDictionaryForSubscribeNext:(void(^)(id key, id value))next traverseCompleted:(void(^)())completed
{
    [[self.rac_sequence.signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
        RACTupleUnpack(id key, id value) = tuple;
        if (next) {
            next(key, value);
        }
    } completed:^{
        if (completed) {
            completed();
        }
    }];
}

@end
