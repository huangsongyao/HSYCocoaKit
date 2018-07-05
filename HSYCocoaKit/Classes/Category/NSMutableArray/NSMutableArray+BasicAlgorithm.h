//
//  NSMutableArray+BasicAlgorithm.h
//  Pods
//
//  Created by huangsongyao on 2018/4/26.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (BasicAlgorithm)

/**
 冒泡排序---降序
 */
- (void)bubbleDescendingOrderSort;

/**
 冒泡排序---升序
 */
- (void)bubbleAscendingOrderSort;

/**
 对字符串进行升序排序

 @return 升序排序后的结果
 */
- (NSArray *)stringAscendingOrderSort;

/**
 对字符串进行降序排序

 @return 降序排序后的结果
 */
- (NSArray *)stringDescendingOrderSort;

@end
