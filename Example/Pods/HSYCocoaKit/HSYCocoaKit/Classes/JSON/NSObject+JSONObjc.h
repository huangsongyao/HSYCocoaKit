//
//  NSObject+JSONObjc.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JSONObjc)

+ (NSString *)convertJsonToStringFromJSONObject:(id)object;
+ (id)convertJsonStringToJSONObjectFromJsonString:(NSString *)jsonString;
+ (id)resolveToJsonObject:(id)json;

@end
