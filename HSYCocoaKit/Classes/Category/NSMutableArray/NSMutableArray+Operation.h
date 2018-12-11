//
//  NSMutableArray+Operation.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (Operation)

/**
 插入一个数据到可变数组的 index = 0 头部

 @param firstObject 要插入的数据
 */
- (void)hsy_insertFirstObject:(id)firstObject;

/**
 插入一个数据到可变数组的 index = (self.count - 1) 尾部

 @param lastObject 要插入的数据
 */
- (void)hsy_insertLastObject:(id)lastObject;

/**
 将 index = 0 位置的数据进行替换

 @param firstObject 要替换的数据
 */
- (void)hsy_replaceFirstObject:(id)firstObject;

/**
 将 index = (self.count - 1) 位置的数据进行替换

 @param lastObject 要替换的数据
 */
- (void)hsy_replaceLastObject:(id)lastObject;

/**
 移除self.firstObject的数据
 */
- (void)hsy_removeFirstObject;

/**
 移除self.lastObject的数据
 */
- (void)hsy_removeLastObject;

@end

NS_ASSUME_NONNULL_END
