//
//  UIApplication+Device.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIApplication+Device.h"

@implementation UIApplication (Device)

+ (UIWindow *)keyWindows
{
    return [[UIApplication sharedApplication] keyWindow];
}

+ (NSString *)mainBundleForPathResource:(NSString *)resource ofType:(NSString *)type
{
    return [[NSBundle mainBundle] pathForResource:resource ofType:type];
}

+ (CGSize)iPhoneStatusBarSize
{
    return [[UIApplication sharedApplication] statusBarFrame].size;
}

+ (CGFloat)statusBarHeight
{
    return [UIApplication iPhoneStatusBarSize].height;
}

+ (id<UIApplicationDelegate>)appDelegate
{
    return [UIApplication sharedApplication].delegate;
}

@end
