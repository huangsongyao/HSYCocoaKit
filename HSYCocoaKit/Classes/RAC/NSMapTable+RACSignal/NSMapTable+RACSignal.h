//
//  NSMapTable+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import <Foundation/Foundation.h>

@class RACSequence;
@interface NSMapTable (RACSequenceAdditions)

@property (nonatomic, copy, readonly) RACSequence *rac_sequence;
@property (nonatomic, copy, readonly) RACSequence *rac_keySequence;
@property (nonatomic, copy, readonly) RACSequence *rac_valueSequence;

@end

@class RACSignal;
@interface NSMapTable (RACSignal)

/**
 *  rac遍历MapTable
 *
 *  @return MapTable元素
 */
- (RACSignal *)rac_traverseMapTable;

/**
 *  rac遍历MapTable
 *
 *  @param next      MapTable的key和value
 *  @param completed 遍历结束后的回调
 */
- (void)rac_traverseMapTableForSubscribeNext:(void(^)(id key, id value))next traverseCompleted:(void(^)(void))completed;

@end
