//
//  NSObject+JSONObjc.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSObject+JSONObjc.h"

@implementation NSObject (JSONObjc)

+ (NSString *)jsonToJSONString:(id)object
{
    NSString *jsonString = [object JSONRepresentation];
    return jsonString;
}

+ (id)jsonStringToJSON:(NSString *)jsonString
{
    NSDictionary *json = [jsonString value];
    return json;
}

+ (id)toJSONObject:(id)json
{
    NSString *jsonString = [self.class jsonToJSONString:json];
    id jsonObject = [self.class jsonStringToJSON:jsonString];
    return jsonObject;
}

@end
