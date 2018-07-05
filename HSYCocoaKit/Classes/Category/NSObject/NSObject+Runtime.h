//
//  NSObject+Runtime.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject (Runtime)

/**
 NSObject子类中的Model动态转为键值对字典

 @return 字典，格式为：key---属性名，value---属性名对应的值
 */
- (NSMutableDictionary *)toRuntimeMutableDictionary;

/**
 动态实现JSON数据解析成NSObject子类的模型

 @param dictionary JSON
 @param classes 要解析成的对象的类名
 @return id
 */
+ (id)objectRuntimeValues:(NSDictionary <NSString *, id>*)dictionary classes:(Class)classes;

/**
 通过Runtime动态设置对象nil成员

 @param object object
 */
+ (void)setRuntimeValue:(id)object;

/**
 获取对象的类名

 @return 类名
 */
- (Class)objectRuntimeClass;

/**
 通过Ivar来获取属性成员的类名

 @param ivar ivar
 @return 属性成员的类名
 */
+ (NSString *)objectRuntimeTypeEncoding:(Ivar)ivar;

/**
 通过Ivar获取属性成员的名称

 @param ivar ivar
 @return 属性成员的名称
 */
+ (NSString *)objectRuntimeName:(Ivar)ivar;

@end
