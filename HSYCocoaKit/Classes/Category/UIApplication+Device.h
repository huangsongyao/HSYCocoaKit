//
//  UIApplication+Device.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>

@interface UIApplication (Device)

/**
 *  获取windows层
 *
 *  @return window层
 */
+ (UIWindow *)keyWindows;

/**
 *  通过文件类型和文件名称获取文件路径，内部加载了“NSFileManager+Finder.h”的方法
 *
 *  @param name     文件名称
 *  @param type     文件后缀类型
 *
 *  @return 文件路径
 */
+ (NSString *)mainBundleForPathResource:(NSString *)name ofType:(NSString *)type;

/**
 设备statusBar的size

 @return statusBar的size
 */
+ (CGSize)iPhoneStatusBarSize;

/**
 *  设备statusBar的高度
 *
 *  @return 高度
 */
+ (CGFloat)statusBarHeight;

/**
 获取AppDelegate

 @return AppDelegate
 */
+ (id<UIApplicationDelegate>)appDelegate;

/**
 获取设备的Screen Bounds

 @return 设备的Screen Bounds
 */
+ (CGRect)iPhoneScreenBounds;

@end
