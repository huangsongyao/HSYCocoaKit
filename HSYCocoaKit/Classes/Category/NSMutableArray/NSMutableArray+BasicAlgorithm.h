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
 NSSortDescriptor排序，通过排序依据keys进行排序，最后返回一个排序结果数组

 @param isAscending 升序或者降序，YES表示升序，NO表示降序
 @param keys 排序依据，例如，NSString按照数值大小排序，则keys就为：@[@"integerValue"]，即，keys为排序依据的属性名称
 @return 排序结果
 */
- (NSArray *)sortDescriptor:(BOOL)isAscending forKeys:(NSArray *)keys;

/**
 NSSortDescriptor排序，通过排序依据keys进行排序，最后会通过“- replaceObjectAtIndex:withObject:”方法，将排序结果替换至self中

 @param isAscending 升序或者降序，YES表示升序，NO表示降序
 @param keys 排序依据，例如，NSString按照数值大小排序，则keys就为：@[@"integerValue"]，即，keys为排序依据的属性名称
 */
- (void)sortUsingDescriptor:(BOOL)isAscending forKeys:(NSArray *)keys;

/**
 NSSortDescriptor降序排序，用于NSString和NSNumber
 */
- (void)bubbleDescendingOrderSort;

/**
 NSSortDescriptor升序排序，用于NSString和NSNumber
 */
- (void)bubbleAscendingOrderSort;

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
