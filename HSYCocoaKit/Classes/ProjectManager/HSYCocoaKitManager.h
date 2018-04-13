//
//  HSYCocoaKitManager.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import <Foundation/Foundation.h>

@interface HSYCocoaKitManager : NSObject

+ (instancetype)hsy_shareInstance;

/**
 NSUserDefaults获取缓存内容

 @param key key
 @return id
 */
+ (id)objectForKey:(NSString *)key;

/**
 NSUserDefaults设置缓存内容

 @param object 缓存对象
 @param key key
 */
+ (void)setObject:(id)object forKey:(NSString *)key;

/**
 NSUserDefaults删除缓存内容

 @param key key
 */
+ (void)removeObjectForKey:(NSString *)key;


@end
