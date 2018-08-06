//
//  NSObject+Runtime.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "NSObject+Runtime.h"

@implementation NSObject (Runtime)

#pragma mark - Model To Dictionary

- (NSMutableDictionary *)toRuntimeMutableDictionary
{
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < outCount; i ++) {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);
        SEL getter = sel_registerName(propertyName);
        if ([self respondsToSelector:getter]) {
            id value = ((id(*)(id, SEL)) objc_msgSend)(self, getter);
            if (value) {
                if ([value isKindOfClass:[self class]]) {
                    value = [value toRuntimeMutableDictionary];
                }
                NSString *key = [NSString stringWithUTF8String:propertyName];
                [dict setObject:value forKey:key];
            }
        }
        
    }
    free(propertyList);
    return dict;
}

#pragma mark - JSON/Dictionary To Model

+ (id)objectRuntimeValues:(NSDictionary <NSString *, id>*)dictionary classes:(Class)classes
{
    id objc = [[classes alloc] init];
    for (NSString *key in dictionary.allKeys) {
        id value = dictionary[key];
        
        objc_property_t property = class_getProperty(classes, key.UTF8String);
        unsigned int outCount = 0;
        objc_property_attribute_t *attributeList = property_copyAttributeList(property, &outCount);
        if (!attributeList) {
            continue;
        }
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString, [key substringFromIndex:1]];
        SEL setter = sel_registerName(methodName.UTF8String);
        if ([objc respondsToSelector:setter]) {
            ((void(*)(id,SEL,id)) objc_msgSend)(objc,setter,value);
        }
        free(attributeList);
    }
    [NSObject setRuntimeValue:objc];
    return objc;
}

#pragma mark - Set Object All Property Content

+ (void)setRuntimeValue:(id)object
{
    unsigned int count = 0;
    Class classes = [object objectRuntimeClass];
    Ivar *ivars = class_copyIvarList(classes, &count);
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        id value = object_getIvar(object, ivar);
        if (!value) {
            id setValue = [NSObject ivarRuntimeValue:[NSObject objectRuntimeTypeEncoding:ivar]];
            if (!setValue) {
                setValue = [NSNull null];
            }
            object_setIvar(object, ivar, setValue);
        }
    }
    free(ivars);
}

#pragma mark - Get Object Classes

- (Class)objectRuntimeClass
{
    if (!self) {
        return [NSError class];
    }
    Class classes = object_getClass(self);
    return classes;
}

#pragma mark - Get Property Type Name

+ (NSString *)objectRuntimeTypeEncoding:(Ivar)ivar
{
    if (!ivar) {
        return nil;
    }
    const char *type = ivar_getTypeEncoding(ivar);
    NSString *objectType = [NSString stringWithUTF8String:type];
    return objectType;
}

+ (id)ivarRuntimeValue:(NSString *)typeName
{
    if ([typeName isEqualToString:@"@\"NSString\""]) {
        return @"";
    } else if ([typeName isEqualToString:@"@\"NSNumber\""]) {
        return @(0);
    } else if ([typeName isEqualToString:@"@\"NSArray\""]) {
        return @[];
    } else if ([typeName isEqualToString:@"@\"NSDictionary\""]) {
        return @{};
    } else if ([typeName isEqualToString:@"@\"NSMutableArray\""]) {
        return [@[] mutableCopy];
    } else if ([typeName isEqualToString:@"@\"NSMutableDictionary\""]) {
        return [@{} mutableCopy];
    } else if ([typeName isEqualToString:@"@\"NSDate\""]) {
        return [NSDate date];
    } else if ([typeName isEqualToString:@"@\"NSData\""]) {
        return [NSData data];
    }
    return nil;
}

#pragma mark - Get Property Name

+ (NSString *)objectRuntimeName:(Ivar)ivar
{
    if (!ivar) {
        return nil;
    }
    const char *name = ivar_getName(ivar);
    NSString *objectName = [NSString stringWithUTF8String:name];
    objectName = [objectName substringWithRange:NSMakeRange(1, (objectName.length - 1))];
    return objectName;
}

#pragma mark - Get All Property Names

+ (NSArray<NSString *> *)objectRumtimeNames:(id)object
{
    unsigned int count = 0;
    Class classes = [object objectRuntimeClass];
    Ivar *ivars = class_copyIvarList(classes, &count);
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSString *propertyName = [NSObject objectRuntimeName:ivar];
        [results addObject:propertyName];
    }
    return [results mutableCopy];
}

@end
