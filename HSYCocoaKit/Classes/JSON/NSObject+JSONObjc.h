//
//  NSObject+JSONObjc.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+JSONWriting.h"
#import "NSString+JSONParsing.h"

@interface NSObject (JSONObjc)

/**
 json对象转json字符串

 @param object json
 @return json字符串
 */
+ (NSString *)jsonToJSONString:(id)object;

/**
 json字符串转json对象

 @param jsonString json字符串
 @return json对象
 */
+ (id)jsonStringToJSON:(NSString *)jsonString;

/**
 未知类型的json或者json字符串转json

 @param json json或者json字符串
 @return json对象
 */
+ (id)toJSONObject:(id)json;

@end
