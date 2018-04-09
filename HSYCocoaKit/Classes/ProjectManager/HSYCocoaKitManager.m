//
//  HSYCocoaKitManager.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "HSYCocoaKitManager.h"

static HSYCocoaKitManager *cocoaKitManager;

@implementation HSYCocoaKitManager

+ (instancetype)shareInstance
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

@end
