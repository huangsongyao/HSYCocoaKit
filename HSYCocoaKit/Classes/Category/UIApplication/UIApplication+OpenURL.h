//
//  UIApplication+OpenURL.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/6.
//

#import <UIKit/UIKit.h>
#import "PublicMacroFile.h"

@interface UIApplication (OpenURL)

+ (BOOL)developerOpenURL:(NSURL *)url;
+ (BOOL)openSafari:(NSString *)url;
+ (void)openSafariServer:(NSString *)url NS_AVAILABLE_IOS(9_0);
+ (void)openSystemSetting NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
