//
//  NSBundle+CFBundle.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/28.
//

#import "NSBundle+CFBundle.h"

@implementation NSBundle (CFBundle)

+ (NSDictionary *)hsy_appBundle
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary;
}

+ (NSString *)hsy_appName
{
    NSDictionary *infoDictionary = [NSBundle hsy_appBundle];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return appName;
}

+ (NSString *)hsy_appVersions
{
    NSDictionary *infoDictionary = [NSBundle hsy_appBundle];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleVersion"];
    return appName;
}

+ (NSString *)hsy_appBundleID
{
    NSDictionary *infoDictionary = [NSBundle hsy_appBundle];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return appName;
}

+ (NSString *)hsy_appBuilds
{
    NSDictionary *infoDictionary = [NSBundle hsy_appBundle];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleVersion"];
    return appName;
}

@end
