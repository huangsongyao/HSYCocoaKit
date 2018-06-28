//
//  NSBundle+CFBundle.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/28.
//

#import <Foundation/Foundation.h>

@interface NSBundle (CFBundle)

/**
 获取mian NSBundle的数据内容

 @return NSDictionary
 */
+ (NSDictionary *)hsy_appBundle;

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
 获取app的bundle id

 @return app的bundle id
 */
+ (NSString *)hsy_appBundleID;

/**
 获取app用于打包的Build版本号

 @return Build版本号
 */
+ (NSString *)hsy_appBuilds;

@end
