//
//  NSMutableArray+BasicAlgorithm.m
//  Pods
//
//  Created by huangsongyao on 2018/4/26.
//
//

#import "NSMutableArray+BasicAlgorithm.h"

@implementation NSMutableArray (BasicAlgorithm)

#pragma mark - Bubbling Down

- (void)bubbleDescendingOrderSort
{
    for (NSInteger i = 0; i < self.count; i ++) {
        for (NSInteger j = 0; j < (self.count - 1 - i); j ++) {
            if ([self[j] integerValue] < [self[(j + 1)] integerValue]) {
                NSInteger temp = [self[j] integerValue];
                self[j] = self[(j + 1)];
                self[(j + 1)] = @(temp);
            }
        }
    }
}

#pragma mark - Bubbling Up

- (void)bubbleAscendingOrderSort
{
    for (NSInteger i = 0; i < self.count; i ++) {
        for (NSInteger j = 0; j < (self.count - 1 - i); j ++) {
            if ([self[j] integerValue] > [self[j + 1] integerValue]) {
                NSInteger temp = [self[j] integerValue];
                self[j] = self[(j + 1)];
                self[j + 1] = @(temp);
            }
        }
    }
}

#pragma mark - NSSortDescriptor String Up

- (NSArray *)stringAscendingOrderSort
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:YES];
    NSArray *sortArray = [self sortedArrayUsingDescriptors:@[descriptor]];;
    return sortArray;
}

#pragma mark - NSSortDescriptor String Down

- (NSArray *)stringDescendingOrderSort
{
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:nil ascending:NO];
    NSArray *sortArray = [self sortedArrayUsingDescriptors:@[descriptor]];;
    return sortArray;
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

@end
