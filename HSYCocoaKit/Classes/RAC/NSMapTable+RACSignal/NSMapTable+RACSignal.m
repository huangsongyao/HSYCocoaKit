//
//  NSMapTable+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "NSMapTable+RACSignal.h"
#import "NSEnumerator+RACSequenceAdditions.h"
#import "ReactiveCocoa.h"

@implementation NSMapTable (RACSequenceAdditions)

- (RACSequence *)rac_sequence {
    NSMapTable *mapTable = [self copy];
    
    // TODO: First class support for dictionary sequences.
    return [mapTable.keyEnumerator.rac_sequence map:^(id key) {
        id value = [mapTable objectForKey:key];
        return RACTuplePack(key, value);
    }];
}

- (RACSequence *)rac_keySequence {
    return self.keyEnumerator.rac_sequence;
}

- (RACSequence *)rac_valueSequence {
    return self.objectEnumerator.rac_sequence;
}

@end

@implementation NSMapTable (RACSignal)

- (RACSignal *)rac_traverseMapTable
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self rac_traverseMapTableForSubscribeNext:^(id key, id value) {
            [subscriber sendNext:@[
                                   key,
                                   value,
                                   ]];
        } traverseCompleted:^{
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- rac_traverseMapTable” file is “NSMapTable+RACSignal.h”");
        }];
    }];
}

- (void)rac_traverseMapTableForSubscribeNext:(void(^)(id key, id value))next traverseCompleted:(void(^)(void))completed
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
