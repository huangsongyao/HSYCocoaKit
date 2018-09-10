//
//  UIApplication+OpenURL.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/6.
//

#import <UIKit/UIKit.h>
#import "PublicMacroFile.h"

@interface UIApplication (OpenURL)

/**
 调用系统的第三方用于
 
 @param url 完整的url地址
 
 @return YES表示可以打开，NO相反
 */
+ (BOOL)developerOpenURL:(NSURL *)url;

/**
 通过http开头的url打开safari浏览器
 
 @param url 完整的url地址
 
 @return YES表示可以打开，NO相反
 */
+ (BOOL)openSafari:(NSString *)url;

/**
 >= iOS9系统下，通过Safari_framework，在app内部调起Safari浏览器
 
 @param url 完整的url地址
 */
+ (void)openSafariServer:(NSString *)url NS_AVAILABLE_IOS(9_0);

/**
 >= iOS8系统下，通过完整的url打开系统设置
 */
+ (void)openSystemSetting NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
