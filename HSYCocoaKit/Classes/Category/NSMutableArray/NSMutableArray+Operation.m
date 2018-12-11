//
//  NSMutableArray+Operation.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/12/11.
//

#import "NSMutableArray+Operation.h"

@implementation NSMutableArray (Operation)

- (void)hsy_insertFirstObject:(id)firstObject
{
    [self insertObject:firstObject atIndex:0];
}

- (void)hsy_insertLastObject:(id)lastObject
{
    [self insertObject:lastObject atIndex:(self.count - 1)];
}

- (void)hsy_replaceFirstObject:(id)firstObject
{
    [self replaceObjectAtIndex:0 withObject:firstObject];
}

- (void)hsy_replaceLastObject:(id)lastObject
{
    [self replaceObjectAtIndex:(self.count - 1) withObject:lastObject];
}

- (void)hsy_removeFirstObject
{
    [self removeObject:self.firstObject];
}

- (void)hsy_removeLastObject
{
    [self removeObject:self.lastObject];
}


@end
