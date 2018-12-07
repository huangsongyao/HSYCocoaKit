//
//  NSMutableArray+BasicAlgorithm.m
//  Pods
//
//  Created by huangsongyao on 2018/4/26.
//
//  冒泡排序：升序条件为“[self[j] integerValue] > [self[j + 1] integerValue]”，降序条件为“[self[j] integerValue] < [self[j + 1] integerValue]”
/*
 for (NSInteger i = 0; i < self.count; i ++) {
    for (NSInteger j = 0; j < (self.count - 1 - i); j ++) {
        if ([self[j] integerValue] > [self[j + 1] integerValue]) {
            id temp = self[j];
            self[j] = self[(j + 1)];
            self[j + 1] = temp;
        }
    }
 }
 */

#import "NSMutableArray+BasicAlgorithm.h"

@implementation NSMutableArray (BasicAlgorithm)

#pragma mark - NSSortDescriptor

- (NSArray *)sortDescriptor:(BOOL)isAscending forKeys:(NSArray *)keys
{
    NSMutableArray *descriptors = [NSMutableArray arrayWithCapacity:keys.count];
    for (id key in keys) {
        id realKey = key;
        if (![realKey isKindOfClass:[NSString class]]) {
            realKey = @"integerValue";
        }
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:realKey ascending:isAscending];
        [descriptors addObject:descriptor];
    }
    NSArray *sortResults = [self sortedArrayUsingDescriptors:[descriptors mutableCopy]];
    return sortResults;
}

- (void)sortUsingDescriptor:(BOOL)isAscending forKeys:(NSArray *)keys
{
    NSArray *sortResults = [self sortDescriptor:isAscending forKeys:keys];
    for (id object in sortResults) {
        [self replaceObjectAtIndex:[sortResults indexOfObject:object] withObject:object];
    }
}

#pragma mark - NSSortDescriptor Number Up

- (NSArray *)ascendingOrderSort
{
    NSArray *sortArray = [self sortDescriptor:YES forKeys:@[[NSNull null]]];
    return sortArray;
}

- (void)bubbleAscendingOrderSort
{
    NSArray *ascendings = self.ascendingOrderSort;
    for (id object in ascendings) {
        [self replaceObjectAtIndex:[ascendings indexOfObject:object] withObject:object];
    }
}

#pragma mark - NSSortDescriptor Number Down

- (NSArray *)descendingOrderSort
{
    NSArray *sortArray = [self sortDescriptor:NO forKeys:@[[NSNull null]]];
    return sortArray;
}

- (void)bubbleDescendingOrderSort
{
    NSArray *ascendings = self.descendingOrderSort;
    for (id object in ascendings) {
        [self replaceObjectAtIndex:[ascendings indexOfObject:object] withObject:object];
    }
}

#pragma mark - Classify

- (NSArray<NSArray *> *)hsy_elementClassifyForKeyPath:(NSString *)keyPath
{
    NSMutableArray<NSArray *> *dataSources = [[NSMutableArray alloc] init];
    NSMutableArray *copySelf = [NSMutableArray arrayWithArray:self];
    for (NSInteger i = 0; i < copySelf.count; i ++) {
        id iObject = copySelf[i];
        NSMutableArray *elements = [[NSMutableArray alloc] init];
        [elements addObject:iObject];
        for (NSInteger j = (i + 1); j < copySelf.count; j ++) {
            id jObject = copySelf[j];
            id iValue = ([keyPath isEqualToString:@"self"] ? iObject : [iObject valueForKeyPath:keyPath]);
            id jValue = ([keyPath isEqualToString:@"self"] ? jObject : [jObject valueForKeyPath:keyPath]);
            if([iValue isEqual:jValue]){
                [elements addObject:jObject];
                [copySelf removeObjectAtIndex:j];
                j -= 1;
            }
        }
        [dataSources addObject:[elements mutableCopy]];
    }
    return [dataSources mutableCopy];
}

- (NSArray<NSArray *> *)stringElementClassify
{
    return [self hsy_elementClassifyForKeyPath:@"self"];
}

- (NSArray<NSArray *> *)numberElementClassify
{
    return [self hsy_elementClassifyForKeyPath:@"self"];
}

- (NSMutableArray *)elementClassify:(NSInteger)forCount
{
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSMutableArray *copys = [self mutableCopy];
    NSInteger count = (self.count / forCount) + 1;
    if ((self.count % forCount) == 0) {
        count --;
    }
    for (NSInteger i = 0; i < count; i ++) {
        NSMutableArray *subResults = [NSMutableArray arrayWithCapacity:forCount];
        for (NSInteger j = 0; j < copys.count; j ++) {
            [subResults addObject:copys[j]];
            [copys removeObjectAtIndex:j];
            j -= 1;
            if (subResults.count % forCount == 0) {
                break;
            }
        }
        [results addObject:subResults];
    }
    return results;
}

@end
