//
//  NSObject+Property.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "NSObject+Property.h"

@implementation NSObject (Property)

- (id)getPropertyForKey:(NSString *)key
{
    return objc_getAssociatedObject(self, key.UTF8String);
}

- (void)setProperty:(id)property forKey:(NSString *)key nonatomic:(objc_AssociationPolicy)nonatomic
{
    [self willChangeValueForKey:key];
    objc_setAssociatedObject(self, key.UTF8String, property, nonatomic);
    [self didChangeValueForKey:key];
}

@end
