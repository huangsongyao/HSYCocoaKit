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
 JSONModl类族用于动态Runtime替换掉null的属性
 */
- (void)setJSONModelRuntimeNullValue;

@end
