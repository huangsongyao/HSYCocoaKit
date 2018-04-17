//
//  HSYCocoaKitManager.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "HSYCocoaKit.h"
#import "HSYFMDBMacro.h"

static HSYCocoaKitManager *cocoaKitManager;

@implementation HSYCocoaKitManager

+ (instancetype)hsy_shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cocoaKitManager = [HSYCocoaKitManager new];
    });
    return cocoaKitManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - UserDefaults

+ (id)hsy_objectForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id object = [userDefaults objectForKey:key];
    return object;
}

+ (void)hsy_setObject:(id)object forKey:(NSString *)key
{
    [self.class hsy_removeObjectForKey:key];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
}

+ (void)hsy_removeObjectForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
}

+ (JSONModel *)hsy_JSONModelForKey:(NSString *)key class:(__unsafe_unretained Class)classes
{
    id object = [self.class hsy_objectForKey:key];
    JSONModel *model = [NSObject hsy_resultObjectToJSONModelWithClasses:classes json:object];
    return model;
}

+ (void)hsy_setJSNModel:(JSONModel *)model forKey:(NSString *)key
{
    NSDictionary *json = model.toDictionary;
    [self.class hsy_setObject:json forKey:key];
}

+ (NSDictionary *)hsy_dictionaryForKey:(NSString *)key
{
    id object = [self.class hsy_objectForKey:key];
    NSDictionary *dic = (NSDictionary *)object;
    return dic;
}

+ (void)hsy_setDictionary:(NSDictionary *)dic forKey:(NSString *)key
{
    [self.class hsy_setObject:dic forKey:key];
}

+ (NSArray *)hsy_arrayForKey:(NSString *)key
{
    id object = [self.class hsy_objectForKey:key];
    NSArray *array = (NSArray *)object;
    return array;
}

+ (void)hsy_setArray:(NSArray *)array forKey:(NSString *)key
{
    [self.class hsy_setObject:array forKey:key];
}

+ (NSString *)hsy_stringForKey:(NSString *)key
{
    id object = [self.class hsy_objectForKey:key];
    NSString *string = (NSString *)object;
    return string;
}

+ (void)hsy_setString:(NSString *)string forKey:(NSString *)key
{
    [self.class hsy_setObject:string forKey:key];
}

@end
