//
//  UIApplication+OpenURL.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/6.
//

#import "UIApplication+OpenURL.h"
#import <SafariServices/SafariServices.h>
#import "UIApplication+Device.h"

@implementation UIApplication (OpenURL)

+ (BOOL)developerOpenURL:(NSURL *)url
{
    BOOL open = [[UIApplication sharedApplication] canOpenURL:url];
    if (open) {
        NSString *urlMethod = @{@(YES) : NSStringFromSelector(@selector(openURL:options:completionHandler:)), @(NO) : NSStringFromSelector(@selector(openURL:))}[@(VERSION_GTR_IOS10)];
        HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([[UIApplication sharedApplication] performSelector:NSSelectorFromString(urlMethod) withObject:url withObject:nil]);
    }
    return open;
}

+ (BOOL)openSafari:(NSString *)url
{
    return [UIApplication developerOpenURL:[NSURL URLWithString:url]];
}

+ (void)openSafariServer:(NSString *)url
{
    if (@available(iOS 9.0, *)) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [[UIApplication appDelegate].window.rootViewController presentViewController:safariViewController animated:YES completion:^{}];
    }
}

+ (void)openSystemSetting
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [UIApplication developerOpenURL:url];
}

@end
