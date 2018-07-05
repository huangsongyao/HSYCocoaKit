//
//  UIApplication+Device.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIApplication+Device.h"
#import "NSFileManager+Finder.h"
#import "PublicMacroFile.h"
#import "HSYBaseLaunchScreenViewController.h"

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
    CGFloat height = [UIApplication iPhoneStatusBarSize].height;
    if (height == 0.0f) {
        height = (IPHONE_HEIGHT == ((CGFloat)kHSYCocoaKitLaunchScreenSize_5_8_Inch) ? 44.0f : 20.0f);
    }
    return height;
}

+ (id<UIApplicationDelegate>)appDelegate
{
    return [UIApplication sharedApplication].delegate;
}

+ (CGRect)iPhoneScreenBounds
{
    return [UIScreen mainScreen].bounds;
}

@end
