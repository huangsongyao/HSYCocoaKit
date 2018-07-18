//
//  NSObject+JSONModelForRuntime.m
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import "NSObject+JSONModelForRuntime.h"
#import "NSObject+Runtime.h"
#import "JSONModel.h"

@implementation NSObject (JSONModelForRuntime)

- (void)setJSONModelRuntimeNullValue
{
    return [NSObject setJSONModelRuntimeNullValue:self];
}

+ (void)setJSONModelRuntimeNullValue:(id)object
{
    unsigned int count = 0;
    Class classes = [object objectRuntimeClass];
    Ivar *ivars = class_copyIvarList(classes, &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        id value = object_getIvar(object, ivar);
        NSString *propertyType = [NSObject objectRuntimeTypeEncoding:ivar];
        BOOL isContains = [NSObject ivarJSONModelContainsSystemClasses:propertyType];
        if (!value || (value && !isContains)) {
            if (value) {
                if ([value isKindOfClass:[NSArray class]]) {
                    for (id obj in (NSArray *)value) {
                        if ([obj isKindOfClass:[JSONModel class]]) {
                            [obj setJSONModelRuntimeNullValue];
                        }
                    }
                } else {
                    [value setJSONModelRuntimeNullValue];
                }
            } else {
                id setValue = [NSObject ivarJSONModelRuntimeValue:propertyType];
                if (!setValue) {
                    setValue = [self.class structJSONModel:propertyType];
                    if (!setValue) {
                        setValue = [NSNull null];
                    }
                }
                object_setIvar(object, ivar, setValue);
            }
        }
    }
    free(ivars);
}

+ (id)structJSONModel:(NSString *)typeName
{
    if (typeName.length == 0) {
        return nil;
    }
    NSString *type = [typeName stringByReplacingOccurrencesOfString:@"@" withString:@""];
    type = [type stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSArray *jsonModelClassNames = [type componentsSeparatedByString:@"<Optional>"];
    if (jsonModelClassNames.count > 0) {
        NSString *className = jsonModelClassNames.firstObject;
        if ([className containsString:@"NSArray"] ||
            [className containsString:@"NSMutableArray"]) {
            return [@[] mutableCopy];
        } else if ([className containsString:@"NSDictionary"] ||
                   [className containsString:@"NSMutableDictionary"]) {
            return [@{} mutableCopy];
        } else {
            id object = [[NSClassFromString(className) alloc] init];
            [NSObject setJSONModelRuntimeNullValue:object];
            return object;
        }
    }
    return nil;
}

+ (id)ivarJSONModelRuntimeValue:(NSString *)typeName
{
    if ([typeName isEqualToString:@"@\"NSString\""] || [typeName isEqualToString:@"@\"NSString<Optional>\""]) {
        return @"";
    } else if ([typeName isEqualToString:@"@\"NSNumber\""] || [typeName isEqualToString:@"@\"NSNumber<Optional>\""]) {
        return @(0);
    } else if ([typeName isEqualToString:@"@\"NSArray\""] || [typeName isEqualToString:@"@\"NSArray<Optional>\""]) {
        return @[];
    } else if ([typeName isEqualToString:@"@\"NSDictionary\""] || [typeName isEqualToString:@"@\"NSDictionary<Optional>\""]) {
        return @{};
    } else if ([typeName isEqualToString:@"@\"NSMutableArray\""] || [typeName isEqualToString:@"@\"NSMutableArray<Optional>\""]) {
        return [@[] mutableCopy];
    } else if ([typeName isEqualToString:@"@\"NSMutableDictionary\""] || [typeName isEqualToString:@"@\"NSMutableDictionary<Optional>\""]) {
        return [@{} mutableCopy];
    } else if ([typeName isEqualToString:@"@\"NSDate\""] || [typeName isEqualToString:@"@\"NSDate<Optional>\""]) {
        return [NSDate date];
    } else if ([typeName isEqualToString:@"@\"NSData\""] || [typeName isEqualToString:@"@\"NSData<Optional>\""]) {
        return [NSData data];
    }
    return nil;
}

+ (BOOL)ivarJSONModelContainsSystemClasses:(NSString *)propertyString
{
    NSArray *systemClasses = @[
                               @"@\"NSString\"",
                               @"@\"NSString<Optional>\"",
                               @"@\"NSNumber\"",
                               @"@\"NSNumber<Optional>\"",
                               @"@\"NSArray\"",
                               @"@\"NSArray<Optional>\"",
                               @"@\"NSDictionary\"",
                               @"@\"NSDictionary<Optional>\"",
                               @"@\"NSMutableArray\"",
                               @"@\"NSMutableArray<Optional>\"",
                               @"@\"NSMutableDictionary\"",
                               @"@\"NSMutableDictionary<Optional>\"",
                               @"@\"NSDate\"",
                               @"@\"NSDate<Optional>\"",
                               @"@\"NSData\"",
                               @"@\"NSData<Optional>\"", ];
    BOOL isContains = [systemClasses containsObject:propertyString];
    return isContains;
}

@end
