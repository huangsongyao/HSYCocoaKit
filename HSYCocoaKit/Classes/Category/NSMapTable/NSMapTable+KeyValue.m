//
//  NSMapTable+KeyValue.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/11/19.
//

#import "NSMapTable+KeyValue.h"

@implementation NSMapTable (KeyValue)

+ (NSMapTable *)hsy_mapTableWithOptions:(NSDictionary<NSNumber *, NSNumber *> *)options keyAndValues:(NSArray<NSDictionary *> *)keyAndValues
{
    NSPointerFunctionsOptions keyOption = (NSPointerFunctionsOptions)[options.allKeys.firstObject integerValue];
    NSPointerFunctionsOptions valueOption = (NSPointerFunctionsOptions)[options.allValues.firstObject integerValue];
    NSMapTable *map = [NSMapTable mapTableWithKeyOptions:keyOption valueOptions:valueOption];
    for (NSDictionary *dictionary in keyAndValues) {
        [map setObject:dictionary.allValues.firstObject forKey:dictionary.allKeys.firstObject];
    }
    return map;
}

@end
