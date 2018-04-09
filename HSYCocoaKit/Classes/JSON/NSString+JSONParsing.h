//
//  NSString+JSONParsing.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>

@interface NSString (JSONParsing)

/**
 json字符串转json对象

 @return json对象
 */
- (id)JSONValue;

/**
 json字符串转字典

 @return json字典
 */
- (NSDictionary *)value;

@end
