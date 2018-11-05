//
//  HSYCustomScript.m
//  HSYCocoaKit_Example
//
//  Created by huangsongyao on 2018/11/5.
//  Copyright © 2018年 huangsongyao. All rights reserved.
//

#import "HSYCustomScript.h"
#import "NSMutableArray+BasicAlgorithm.h"

@interface NSArray (NSLog)

- (NSString *)scriptDescription;

@end

@implementation NSArray (NSLog)

- (NSString *)scriptDescription
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    for (NSDictionary *obj in self) {
        [str appendFormat:@"\t%@ = %@, \n", obj.allKeys.firstObject, obj.allValues.firstObject];
    }
    [str appendString:@")"];
    return str;
}

@end

@interface NSDictionary (NSLog)

- (NSString *)scriptDescription;

@end

@implementation NSDictionary (NSLog)

- (NSString *)scriptDescription
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value = self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    return str;
}

@end

@implementation HSYCustomScript

+ (HSYCustomScript *)customScript
{
    HSYCustomScript *script = [[HSYCustomScript alloc] init];
    [script script];
    return script;
}

- (void)script
{
    //@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"",
    NSMutableArray *names = [@[@"黄开端", @"黄淞垚", @"马炼虹", @"戴小红", @"黄开端", @"黄淞垚", @"马炼虹", @"戴小红", @"黄开端", @"黄淞垚", ] mutableCopy];
    
    NSArray<NSArray *> *list = names.stringElementClassify;
    NSMutableArray<NSDictionary *> *realList = [[NSMutableArray alloc] init];
    for (NSArray *subList in list) {
        NSString *firstName = subList.firstObject;
        NSNumber *thisDays = @(subList.count);
        [realList addObject:@{firstName : thisDays}];
    }
    NSLog(@"++++++++++++++\n %@ \n+++++++++++++", realList.scriptDescription);
    NSLog(@"completed");
}

@end
