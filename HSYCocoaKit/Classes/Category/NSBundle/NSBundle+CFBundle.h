//
//  NSBundle+CFBundle.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/28.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitBundleContent) {
    
    kHSYCocoaKitBundleContentOSBuild                = 8325,         //BuildMachineOSBuild
    kHSYCocoaKitBundleContentDevelopmentRegion,                     //CFBundleDevelopmentRegion
    kHSYCocoaKitBundleContentDisplayName,                           //CFBundleDisplayName
    kHSYCocoaKitBundleContentExecutable,                            //CFBundleExecutable
    kHSYCocoaKitBundleContentIdentifier,                            //CFBundleIdentifier
    kHSYCocoaKitBundleContentInfoDictionaryVersion,                 //CFBundleInfoDictionaryVersion
    kHSYCocoaKitBundleContentName,                                  //CFBundleName
    kHSYCocoaKitBundleContentNumericVersion,                        //CFBundleNumericVersion
    kHSYCocoaKitBundleContentPackageType,                           //CFBundlePackageType
    kHSYCocoaKitBundleContentShortVersionString,                    //CFBundleShortVersionString
    kHSYCocoaKitBundleContentSupportedPlatforms,                    //CFBundleSupportedPlatforms
    kHSYCocoaKitBundleContentVersion,                               //CFBundleVersion
    kHSYCocoaKitBundleContentPlatformVersion,                       //DTPlatformVersion
    
};

@interface NSBundle (CFBundle)

/**
 获取mian NSBundle的数据内容

 @return NSDictionary
 */
+ (NSDictionary *)hsy_appBundle;

/**
 通过枚举获取对应mainBundle下的value内容，枚举内容为大部分通用key，如不够自己自行添加

 @param type kHSYCocoaKitBundleContent枚举
 @return 对应mainBundle下的value内容
 */
+ (id)hsy_appBundleContentForType:(kHSYCocoaKitBundleContent)type;

/**
 获取app的应用名称

 @return 应用名称
 */
+ (NSString *)hsy_appName;

/**
 获取app当前的版本号

 @return 当前版本号
 */
+ (NSString *)hsy_appVersions;

/**
 获取app的Bundle id

 @return app的Bundle id
 */
+ (NSString *)hsy_appBundleID;

/**
 获取app用于打包的Build版本号

 @return Build版本号
 */
+ (NSString *)hsy_appBuilds;

/**
 获取当前编译中的工程Target的名称

 @return Target的名称
 */
+ (NSString *)hsy_appBundleTargetName;

/**
 获取当前编译的设备名称

 @return 当前编译的设备名称
 */
+ (NSString *)hsy_iPhoneSimulatorName;

@end
