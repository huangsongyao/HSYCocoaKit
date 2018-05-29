//
//  NSArray+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface NSArray (RACSignal)

/**
 *  rac遍历数组，并返回sendNext信号，当遍历完成后则返回completed信号并释放
 *
 *  @return 遍历后的信号，格式为：@{@(遍历对象的index) : 遍历对象的id}
 */
- (RACSignal *)rac_traverseArray;

/**
 过滤数组，RAC模式
 
 @param completed 过滤条件，此block会被触发数组的count次，并且根据返回的布尔值（YES表示通过信号，NO表示吞噬信号），判断是否触发map和next
 @param map 映射，用于对datas数组的数据进行映射处理，即：当回调被触发，表示datas数组的当前元素满足条件，时，允许使用map回调一个映射的对象
 @return RACSignal信号
 */
- (RACSignal *)rac_filterUntilCompleted:(BOOL(^)(id predicate))completed toMap:(id(^)(id value))map;

/**
 过滤数组，RAC模式
 
 @param completed 过滤条件，此block会被触发数组的count次，并且根据返回的布尔值（YES表示通过信号，NO表示吞噬信号）
 @return RACSignal信号
 */
- (RACSignal *)rac_filterUntilCompleted:(BOOL(^)(id predicate))completed;


@end
