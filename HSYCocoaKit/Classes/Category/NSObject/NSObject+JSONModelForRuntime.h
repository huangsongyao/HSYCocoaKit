//
//  NSObject+JSONModelForRuntime.h
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONModelForRuntime)

/**
 JSONModl类族用于动态Runtime替换掉null的属性，规则为：对当前的JSONModel对象进行property的遍历，当碰到为nil的通用类[NSString、NSNumber、NSArray、NSMutableArray、NSDictionary、NSMutableDictionary]等，动态对这些通用类进行alloc操作，保证为nil的通用属性指针指向某个对应类的内存块，当property不为nil时，则判断这个property是否为JSONModel的类族，如果是，则对这个类执行“- setJSONModelRuntimeNullValue”方法递归，如果这个property为数组，并且数组中存在了JSONModel的类族的对象，则对这个property数组进行遍历，并对每个属于JSONModel的类族的对象执行执行“- setJSONModelRuntimeNullValue”方法递归
 */
- (void)setJSONModelRuntimeNullValue;

@end
