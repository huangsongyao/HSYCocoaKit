//
//  NSMapTable+KeyValue.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/11/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMapTable (KeyValue)

/**
 快速创建NSMapTable

 @param options key和value的管理类型，格式为：@{@(NSPointerFunctionsOptions枚举) : @(NSPointerFunctionsOptions枚举)}
 @param keyAndValues key和value的值，格式为：@[@{key1 : value2}, @{key2 : value2}, ...]
 @return NSMapTable
 */
+ (NSMapTable *)hsy_mapTableWithOptions:(NSDictionary<NSNumber *, NSNumber *> *)options keyAndValues:(NSArray<NSDictionary *> *)keyAndValues;

@end

NS_ASSUME_NONNULL_END
