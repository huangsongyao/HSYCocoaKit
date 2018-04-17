//
//  UIApplication+Device.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIApplication+Device.h"
#import "NSFileManager+Finder.h"

@implementation UIApplication (Device)

+ (UIWindow *)keyWindows
{
    return [[UIApplication sharedApplication] keyWindow];
}

+ (NSString *)mainBundleForPathResource:(NSString *)name ofType:(NSString *)type
{
    return [NSFileManager finderFileFromName:name fileType:type];
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
