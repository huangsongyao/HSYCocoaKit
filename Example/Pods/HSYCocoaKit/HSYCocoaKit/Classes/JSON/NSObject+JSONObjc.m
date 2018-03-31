//
//  NSObject+JSONObjc.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSObject+JSONObjc.h"
#import "NSObject+JSONWriting.h"
#import "NSString+JSONParsing.h"

@implementation NSObject (JSONObjc)

+ (NSString *)convertJsonToStringFromJSONObject:(id)object
{
    if (!object) {
        return nil;
    }
    NSString *jsonString = [object JSONRepresentation];
    return jsonString;
}

+ (id)convertJsonStringToJSONObjectFromJsonString:(NSString *)jsonString
{
    if (!jsonString) {
        return nil;
    }
    NSDictionary *dic = jsonString.value;
    return dic;
}

+ (id)resolveToJsonObject:(id)json
{
    NSString *responseString = [self convertJsonToStringFromJSONObject:json];
    id jsonObject = [self convertJsonStringToJSONObjectFromJsonString:responseString];
    return jsonObject;
}

@end
