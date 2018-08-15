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
 冒泡排序---降序，适用于NSNumber
 */
- (void)bubbleDescendingOrderSort;

/**
 冒泡排序---升序，适用于NSNumber
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

/**
 只试用于纯NSString的数组，用于对相同字符串进行分类，返回一个分类后的纯NSString二维数组

 @return 分类后的纯NSString二维数组
 */
- (NSArray<NSArray *> *)stringElementClassify;

/**
 只试用于纯NSNmber的数组，用于对相同字符串进行分类，返回一个分类后的纯NSNmber二维数组
 
 @return 分类后的纯NSNmber二维数组
 */
- (NSArray<NSArray *> *)numberElementClassify;

/**
 将可变数组按顺序，拆分为一个二维数组，每个子数组的元素个数为[1, forCount]闭区间

 @param forCount 每个子数组的最大存储元素个数
 @return 按顺序拆分的二维数组
 */
- (NSMutableArray *)elementClassify:(NSInteger)forCount;

@end
