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

+ (void)setObject:(id)object forKey:(NSString *)key
{
    
}

@end
