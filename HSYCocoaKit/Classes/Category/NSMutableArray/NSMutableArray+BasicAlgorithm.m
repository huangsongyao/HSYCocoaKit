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

- (NSArray<NSArray *> *)stringElementClassify
{
    NSMutableArray<NSArray *> *dataSources = [[NSMutableArray alloc] init];
    NSMutableArray *copySelf = [NSMutableArray arrayWithArray:self];
    for (NSInteger i = 0; i < copySelf.count; i ++) {
        NSString *iString = copySelf[i];
        NSMutableArray *elements = [[NSMutableArray alloc] init];
        [elements addObject:iString];
        for (NSInteger j = (i + 1); j < copySelf.count; j ++) {
            NSString *jString = copySelf[j];
            if([iString isEqualToString:jString]){
                [elements addObject:jString];
                [copySelf removeObjectAtIndex:j];
                j -= 1;
            }
        }
        [dataSources addObject:[elements mutableCopy]];
    }
    return [dataSources mutableCopy];
}

- (NSArray<NSArray *> *)numberElementClassify
{
    NSMutableArray<NSArray *> *dataSources = [[NSMutableArray alloc] init];
    NSMutableArray *copySelf = [NSMutableArray arrayWithArray:self];
    for (NSInteger i = 0; i < copySelf.count; i ++) {
        NSNumber *iNumber = copySelf[i];
        NSMutableArray *elements = [[NSMutableArray alloc] init];
        [elements addObject:iNumber];
        for (NSInteger j = (i + 1); j < copySelf.count; j ++) {
            NSNumber *jNumber = copySelf[j];
            if([iNumber isEqualToNumber:jNumber]){
                [elements addObject:jNumber];
                [copySelf removeObjectAtIndex:j];
                j -= 1;
            }
        }
        [dataSources addObject:[elements mutableCopy]];
    }
    return [dataSources mutableCopy];
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
