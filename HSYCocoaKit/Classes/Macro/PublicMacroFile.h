//
//  PublicMacroFile.h
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#ifndef PublicMacroFile_h
#define PublicMacroFile_h

#import "UIApplication+Device.h"
#import "HSYBaseLaunchScreenViewController.h"
#import "NSBundle+CFBundle.h"

//debug模式下的NSLog
#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)

#else

#define NSLog(...)
#define debugMethod()

#endif

//国际化使用的文字赋值
#define HSYLOCALIZED(ver)                                               NSLocalizedString(ver, nil)


//屏幕尺寸
#define IPHONE_WIDTH                                                    ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_HEIGHT                                                   ([UIScreen mainScreen].bounds.size.height)


//设备系统
#define IPHONE_SYSTEM_VERSION                                           [[[UIDevice currentDevice] systemVersion] floatValue]


//设备系统范围
#define VERSION_GTR_IOS7                                                (IPHONE_SYSTEM_VERSION > 7.0 ? YES : NO)
#define VERSION_GTR_IOS8                                                (IPHONE_SYSTEM_VERSION > 8.0 ? YES : NO)
#define VERSION_GTR_IOS9                                                (IPHONE_SYSTEM_VERSION > 9.0 ? YES : NO)
#define VERSION_GTR_IOS10                                               (IPHONE_SYSTEM_VERSION > 10.0 ? YES : NO)
#define VERSION_GTR_IOS11                                               (IPHONE_SYSTEM_VERSION > 11.0 ? YES : NO)


//statusBar高度
#define IPHONE_STATUS_BAR_HEIGHT                                        ([UIApplication statusBarHeight])


//导航栏高度
#define IPHONE_STATE_BAR_HEIGHT                                         IPHONE_STATUS_BAR_HEIGHT
#define IPHONE_NAVIGATION_BAR_HEIGHT                                    (44.0f)
#define IPHONE_BAR_HEIGHT                                               (IPHONE_STATE_BAR_HEIGHT + IPHONE_NAVIGATION_BAR_HEIGHT)
#define TABLE_VIEW_HEIGHT                                               (IPHONE_HEIGHT - IPHONE_BAR_HEIGHT)


//TabBar高度
#define IPHONE_TABBAR_HEIGHT                                            ([HSYBaseLaunchScreenViewController iPhoneXDevice] ? 83.0f : 49.0f)


//iPhoneX设备底部偏移量
#define IPHONE_X_BOTTOM_HEIGHT                                          ([HSYBaseLaunchScreenViewController iPhoneXDevice] ? (83.0f - 49.0f) : 0.0f)


//设备分辨率
#define DEVICERESOLUTION                                                (IPHONE_WIDTH * IPHONE_HEIGHT * ([UIScreen mainScreen].scale))


//weakSelf & strongSelf
#define __WEAKSELF(id)                                                  __weak typeof(X) weakSelf      = id
#define __STRONGSELF(id)                                                __strong typeof(X) strongSelf  = id


//转场方向
#define HSYCustomViewAnimationSubtypeFromRight                          kCATransitionFromRight          //右边
#define HSYCustomViewAnimationSubtypeFromLeft                           kCATransitionFromLeft           //左边
#define HSYCustomViewAnimationSubtypeFromTop                            kCATransitionFromTop            //上边
#define HSYCustomViewAnimationSubtypeFromBottom                         kCATransitionFromBottom         //下边
#define HSYCustomViewAnimationSubtypeFromeMiddle                        kCATruncationMiddle


//获取RGB颜色
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r, g, b) RGBA(r, g, b, 1.0f)
#define HexColor(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:1.0f]
#define HexColorA(c, a) [UIColor colorWithRed:((c>>16)&0xFF)/255.0f green:((c>>8)&0xFF)/255.0f blue:(c&0xFF)/255.0f alpha:a]
#define HexColorString(rgbValue) [UIColor colorWithRed:((float)((strtoul(((NSString *)rgbValue).UTF8String, 0, 16) & 0xFF0000) >> 16))/255.0 green:((float)((strtoul(((NSString *)rgbValue).UTF8String, 0, 16) & 0xFF00) >> 8))/255.0 blue:((float)(strtoul(((NSString *)rgbValue).UTF8String, 0, 16) & 0xFF))/255.0 alpha:1.0]


//展示页的宏
#define SHOWIMAGE(ver)                                                  SHPWVC_BG(ver)


//获取文件路径
#define GET_FILES_PATH(name, type)                                      [UIScreen getMainBundleForPathForResource:name ofType:type]


//加载图片
#define CREATE_IMG(imageName)                                           [UIImage imageNamed:imageName]


//系统文字的font
#define HSYFONTSIZE(ver)                                                [UIFont systemFontOfSize:ver]
//系统文字的font 加粗
#define HSYFONTBLODSIZE(ver)                                            [UIFont boldSystemFontOfSize:ver]

//常用颜色
#define CLEAR_COLOR                                                     [UIColor clearColor]    //透明色
#define BLACK_COLOR                                                     [UIColor blackColor]    //黑色
#define WHITE_COLOR                                                     [UIColor whiteColor]    //白色
#define SEGMENTED_CONTROL_DEFAULT_SELECTED_COLOR                        HexColorString(@"77D4FB")
#define NAV_DEFAULT_COLOR                                               RGB(204, 204, 204)


//沙盒下存放配置文件的文件夹路径
#define PATHDOCUMENT_CONFIG_FILE_PATH                                   @"Config"

//压缩视频帧数
#define CHANGE_VIDEO_FGS                                                600

//系统字体字号
#define UI_FONT_SIZE(size)                                              [UIFont systemFontOfSize:size]
#define UI_BOLD_FONT_SIZE(size)                                         [UIFont boldSystemFontOfSize:size]


//常用系统字号
#define UI_SYSTEM_FONT_18                                               UI_FONT_SIZE(18)
#define UI_SYSTEM_FONT_17                                               UI_FONT_SIZE(17)
#define UI_SYSTEM_FONT_16                                               UI_FONT_SIZE(16)
#define UI_SYSTEM_FONT_15                                               UI_FONT_SIZE(15)
#define UI_SYSTEM_FONT_14                                               UI_FONT_SIZE(14)
#define UI_SYSTEM_FONT_13                                               UI_FONT_SIZE(13)
#define UI_SYSTEM_FONT_12                                               UI_FONT_SIZE(12)
#define UI_SYSTEM_FONT_11                                               UI_FONT_SIZE(11)
#define UI_SYSTEM_FONT_10                                               UI_FONT_SIZE(10)
#define UI_SYSTEM_FONT_9                                                UI_FONT_SIZE(9)


//常用系统加粗字号
#define UI_BOLD_SYSTEM_FONT_18                                          UI_BOLD_FONT_SIZE(18)
#define UI_BOLD_SYSTEM_FONT_17                                          UI_BOLD_FONT_SIZE(17)
#define UI_BOLD_SYSTEM_FONT_16                                          UI_BOLD_FONT_SIZE(16)
#define UI_BOLD_SYSTEM_FONT_15                                          UI_BOLD_FONT_SIZE(15)
#define UI_BOLD_SYSTEM_FONT_14                                          UI_BOLD_FONT_SIZE(14)
#define UI_BOLD_SYSTEM_FONT_13                                          UI_BOLD_FONT_SIZE(13)
#define UI_BOLD_SYSTEM_FONT_12                                          UI_BOLD_FONT_SIZE(12)
#define UI_BOLD_SYSTEM_FONT_11                                          UI_BOLD_FONT_SIZE(11)
#define UI_BOLD_SYSTEM_FONT_10                                          UI_BOLD_FONT_SIZE(10)
#define UI_BOLD_SYSTEM_FONT_9                                           UI_BOLD_FONT_SIZE(9)


//系统默认字号适配宏，wordSize表示通用字号，fitSize表示适配字号，最终字号为(wordSize-fitSize)
#define UI_FONT_FIT_SIZE(wordSize, fitSize)                             UI_FONT_SIZE((wordSize-fitSize))
#define UI_BOLD_FONT_FIT_SIZE(wordSize, fitSize)                        UI_BOLD_FONT_SIZE((wordSize-fitSize))

//红点字体
#define UI_RED_POINT_FONT                                               UI_BOLD_SYSTEM_FONT_9


//版本弃用
#define HSY_DEPRECATED(_iOS_version)                                    __attribute__((deprecated))


//版本启用，默认为从iOS8系统开始
#define HSY_AVAILABLE_IOS_8                                             8_0


//layer层锚点
#define HSYCOCOAKIT_ANCHOR_POINT_X00_Y00                CGPointMake(0.0f, 0.0f)
#define HSYCOCOAKIT_ANCHOR_POINT_X05_Y00                CGPointMake(0.5f, 0.0f)
#define HSYCOCOAKIT_ANCHOR_POINT_X10_Y00                CGPointMake(1.0f, 0.0f)

#define HSYCOCOAKIT_ANCHOR_POINT_X00_Y05                CGPointMake(0.0f, 0.5f)
#define HSYCOCOAKIT_ANCHOR_POINT_X05_Y05                CGPointMake(0.5f, 0.5f)
#define HSYCOCOAKIT_ANCHOR_POINT_X10_Y05                CGPointMake(1.0f, 0.5f)

#define HSYCOCOAKIT_ANCHOR_POINT_X00_Y10                CGPointMake(0.0f, 1.0f)
#define HSYCOCOAKIT_ANCHOR_POINT_X05_Y10                CGPointMake(0.5f, 1.0f)
#define HSYCOCOAKIT_ANCHOR_POINT_X10_Y10                CGPointMake(1.0f, 1.0f)


//app信息
#define APP_INFO_NAME                                   [NSBundle hsy_appName]
#define APP_INFO_VERSIONS                               [NSBundle hsy_appVersions]
#define APP_INFO_BUNDLE_ID                              [NSBundle hsy_appBundleID]
#define APP_INFO_BUILDS                                 [NSBundle hsy_appBuilds]



#endif /* PublicMacroFile_h */
