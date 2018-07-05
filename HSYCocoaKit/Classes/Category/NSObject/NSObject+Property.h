//
//  NSObject+Property.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Property)

/**
 runtime动态添加属性成员

 @param key key
 @return id
 */
- (id)getPropertyForKey:(NSString *)key;

/**
 runtime动态添加属性成员

 @param property id
 @param key key
 @param nonatomic objc_AssociationPolicy枚举
 */
- (void)setProperty:(id)property
             forKey:(NSString *)key
          nonatomic:(objc_AssociationPolicy)nonatomic;

@end
