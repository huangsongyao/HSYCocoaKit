//
//  NSObject+JSONModel.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSObject+JSONModel.h"
#import "JSONModel.h"
#import "NSObject+JSONModelForRuntime.h"

@implementation NSObject (JSONModel)

- (id)hsy_resultObjectToJSONModelWithClasses:(Class)classes json:(id)json
{
    if (!json) {
        return nil;
    }
    if ([json isKindOfClass:[NSString class]]) {
        return [self hsy_resultObjectToBeanWithClass:classes jsonString:json];
    } else {
        return [self hsy_resultObjectToBeanWithClass:classes json:json];
    }
}

+ (id)hsy_resultObjectToJSONModelWithClasses:(Class)classes json:(id)json
{
    return [[self alloc] hsy_resultObjectToJSONModelWithClasses:classes json:json];
}

#pragma mark - Resolve JSON

- (id)hsy_resultObjectToBeanWithClass:(Class)classes json:(id)json
{
    if (!json) {
        return nil;
    }
    id jsonObject = [NSString toJSONObject:json];
    return [self resolveToModelForJsonObject:jsonObject classes:classes];
}


+ (id)hsy_resultObjectToBeanWithClass:(Class)classes json:(id)json
{
    return [[self alloc] hsy_resultObjectToBeanWithClass:classes json:json];
}


- (id)hsy_resultObjectToBeanWithClass:(Class)classes jsonString:(NSString *)jsonString
{
    if (!jsonString) {
        return nil;
    }
    id jsonObject = [NSString jsonStringToJSON:jsonString];
    return [self resolveToModelForJsonObject:jsonObject classes:classes];
}

+ (id)hsy_resultObjectToBeanWithClass:(Class)classes jsonString:(NSString *)jsonString
{
    return [[self alloc] hsy_resultObjectToBeanWithClass:classes jsonString:jsonString];
}

/**
 *  jsonmodel解析方法
 *
 *  @param jsonObject json对象
 *  @param classes    bean的类名
 *
 *  @return 解析后的bean
 */
- (id)resolveToModelForJsonObject:(id)jsonObject classes:(Class)classes
{
    id result = nil;
    NSError *error = nil;
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        result = [[classes alloc] initWithDictionary:(NSDictionary *)jsonObject error:&error];
        if (!error) {
            [result setJSONModelRuntimeNullValue];
            return result;
        }
    } else if ([jsonObject isKindOfClass:[NSArray class]]) {
        result = [classes arrayOfModelsFromDictionaries:(NSArray *)jsonObject error:&error];
        if (!error) {
            [result setJSONModelRuntimeNullValue];
            return result;
        }
    } else {
        return nil;
    }
    return error;
}

@end
