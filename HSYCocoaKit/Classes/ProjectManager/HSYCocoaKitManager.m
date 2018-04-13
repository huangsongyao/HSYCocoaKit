//
//  HSYCocoaKitManager.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "HSYCocoaKit.h"

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

+ (id)objectForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    id object = [userDefaults objectForKey:key];
    return object;
}

+ (void)setObject:(id)object forKey:(NSString *)key
{
    [self.class removeObjectForKey:key];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:object forKey:key];
}

+ (void)removeObjectForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:key];
}


@end
