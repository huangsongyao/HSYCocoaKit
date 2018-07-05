//
//  NSArray+Finder.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import "NSArray+Finder.h"

NSInteger const kDefaultFindFailureIndex = -1234;

@implementation NSArray (Finder)

- (NSInteger)finderObject:(id)object
{
    for (id obj in self) {
        if ([obj isEqual:object]) {
            return [self indexOfObject:obj];
        }
    }
    return kDefaultFindFailureIndex;
}

- (BOOL)objectIsExist:(id)object
{
    NSInteger i = [self finderObject:object];
    return (i != kDefaultFindFailureIndex);
}

- (NSInteger)finderObjectIndex:(id)object
{
    NSInteger i = [self finderObject:object];
    if (i == kDefaultFindFailureIndex) {
        i = 0;
    }
    return i;
}

@end
