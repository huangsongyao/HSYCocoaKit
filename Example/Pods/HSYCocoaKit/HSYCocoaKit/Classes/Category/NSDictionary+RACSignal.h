//
//  NSDictionary+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NSDictionary (RACSignal)

/**
 *  rac遍历字典
 *
 *  @return 字典元素，包含了key-value
 */
- (RACSignal *)rac_traverseDictionary;

/**
 *  rac遍历字典，block模式
 *
 *  @param next      遍历的字典所包含的元素，key-value
 *  @param completed 遍历结束后
 */
- (void)rac_traverseDictionaryForSubscribeNext:(void(^)(id key, id value))next traverseCompleted:(void(^)())completed;

@end
