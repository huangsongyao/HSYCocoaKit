//
//  NSBundle+CFBundle.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/28.
//

#import "NSBundle+CFBundle.h"

@implementation NSBundle (CFBundle)

#pragma mark - MainBundle InfoDictionary

+ (NSDictionary *)hsy_appBundle
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary;
}

#pragma mark - kHSYCocoaKitBundleContent Change To Key

+ (NSString *)toMainBundleKey:(kHSYCocoaKitBundleContent)type
{
    NSDictionary *dic = @{
                          @(kHSYCocoaKitBundleContentOSBuild) : @"BuildMachineOSBuild",
                          @(kHSYCocoaKitBundleContentDevelopmentRegion) : @"CFBundleDevelopmentRegion",
                          @(kHSYCocoaKitBundleContentDisplayName) : @"CFBundleDisplayName",
                          @(kHSYCocoaKitBundleContentExecutable) : @"CFBundleExecutable",
                          @(kHSYCocoaKitBundleContentIdentifier) : @"CFBundleIdentifier",
                          @(kHSYCocoaKitBundleContentInfoDictionaryVersion) : @"CFBundleInfoDictionaryVersion",
                          @(kHSYCocoaKitBundleContentName) : @"CFBundleName",
                          @(kHSYCocoaKitBundleContentNumericVersion) : @"CFBundleNumericVersion",
                          @(kHSYCocoaKitBundleContentPackageType) : @"CFBundlePackageType",
                          @(kHSYCocoaKitBundleContentShortVersionString) : @"CFBundleShortVersionString",
                          @(kHSYCocoaKitBundleContentSupportedPlatforms) : @"CFBundleSupportedPlatforms",
                          @(kHSYCocoaKitBundleContentVersion) : @"CFBundleVersion",
                          @(kHSYCocoaKitBundleContentPlatformVersion) : @"DTPlatformVersion",
                          };
    return dic[@(type)];
}

#pragma mark - Get Value

+ (id)hsy_appBundleContentForType:(kHSYCocoaKitBundleContent)type
{
    return [NSBundle appBundleContentForKey:[NSBundle toMainBundleKey:type]];
}

+ (id)appBundleContentForKey:(NSString *)key
{
    NSDictionary *infoDictionary = [NSBundle hsy_appBundle];
    id value = [infoDictionary objectForKey:key];
    return value;
}

#pragma mark - Common Use

+ (NSString *)hsy_appName
{
    return [NSBundle hsy_appBundleContentForType:kHSYCocoaKitBundleContentDisplayName];
}

+ (NSString *)hsy_appVersions
{
    return [NSBundle hsy_appBundleContentForType:kHSYCocoaKitBundleContentShortVersionString];
}

+ (NSString *)hsy_appBundleID
{
    return [NSBundle hsy_appBundleContentForType:kHSYCocoaKitBundleContentIdentifier];
}

+ (NSString *)hsy_appBuilds
{
    return [NSBundle hsy_appBundleContentForType:kHSYCocoaKitBundleContentVersion];
}

+ (NSString *)hsy_appBundleTargetName
{
    return [NSBundle hsy_appBundleContentForType:kHSYCocoaKitBundleContentExecutable];
}

+ (NSString *)hsy_iPhoneSimulatorName
{
    NSArray *platforms = [NSBundle hsy_appBundleContentForType:kHSYCocoaKitBundleContentSupportedPlatforms];
    return platforms.firstObject;
}

@end
