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

// debug 模式下的 NSLog
#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)

#else

#define NSLog(...)
#define debugMethod()

#endif

// 国际化使用的文字赋值
#define HSYLOCALIZED(ver)                                               NSLocalizedString(ver, nil)


// 屏幕尺寸
#define IPHONE_WIDTH                                                    ([UIScreen mainScreen].bounds.size.width)
#define IPHONE_HEIGHT                                                   ([UIScreen mainScreen].bounds.size.height)


// 设备系统
#define IPHONE_SYSTEM_VERSION               [[[UIDevice currentDevice] systemVersion] floatValue]


// 设备系统范围
#define VERSION_GTR_IOS7                    (IPHONE_SYSTEM_VERSION > 7.0 ? YES : NO)
#define VERSION_GTR_IOS8                    (IPHONE_SYSTEM_VERSION > 8.0 ? YES : NO)
#define VERSION_GTR_IOS9                    (IPHONE_SYSTEM_VERSION > 9.0 ? YES : NO)
#define VERSION_GTR_IOS10                   (IPHONE_SYSTEM_VERSION > 10.0 ? YES : NO)

// statusBar高度
#define IPHONE_STATUS_BAR_HEIGHT                                        ([UIApplication statusBarHeight])

// 导航栏高度
#define IPHONE_STATE_BAR_HEIGHT                                         IPHONE_STATUS_BAR_HEIGHT
#define IPHONE_NAVIGATION_BAR_HEIGHT                                    (44.0f)
#define IPHONE_BAR_HEIGHT                                               (IPHONE_STATE_BAR_HEIGHT + IPHONE_NAVIGATION_BAR_HEIGHT)
#define TABLE_VIEW_HEIGHT                                               (IPHONE_HEIGHT - IPHONE_BAR_HEIGHT)


// 设备分辨率
#define DEVICERESOLUTION                                                (IPHONE_WIDTH * IPHONE_HEIGHT * ([UIScreen mainScreen].scale))


#define __WEAKSELF(id)                                                  __weak typeof(X) weakSelf      = id
#define __STRONGSELF(id)                                                __strong typeof(X) strongSelf  = id


// 转场方向
#define HSYCustomViewAnimationSubtypeFromRight                          kCATransitionFromRight          //右边
#define HSYCustomViewAnimationSubtypeFromLeft                           kCATransitionFromLeft           //左边
#define HSYCustomViewAnimationSubtypeFromTop                            kCATransitionFromTop            //上边
#define HSYCustomViewAnimationSubtypeFromBottom                         kCATransitionFromBottom         //下边
#define HSYCustomViewAnimationSubtypeFromeMiddle                        kCATruncationMiddle



// 展示页的宏
#define SHOWIMAGE(ver)                                                  SHPWVC_BG(ver)


// 获取文件路径
#define GET_FILES_PATH(name, type)                                      [UIScreen getMainBundleForPathForResource:name ofType:type]


// 加载图片
#define CREATE_IMG(imageName)                                           [UIImage imageNamed:imageName]


// 系统文字的font
#define HSYFONTSIZE(ver)                                                [UIFont systemFontOfSize:ver]
// 系统文字的font 加粗
#define HSYFONTBLODSIZE(ver)                                            [UIFont boldSystemFontOfSize:ver]

// 常用颜色
#define CLEAR_COLOR                                                     [UIColor clearColor]    //透明色
#define BLACK_COLOR                                                     [UIColor blackColor]    //黑色
#define WHITE_COLOR                                                     [UIColor whiteColor]    //白色
#define CLEAR_COLOR                                                     [UIColor clearColor]    // 透明色


// 沙盒下存放配置文件的文件夹路径
#define PATHDOCUMENT_CONFIG_FILE_PATH                                   @"Config"

// 沙盒下缓存从mov转mp4格式的视频文件路径后缀
#define CHANGE_VIDEO_PATH_SUFFIX                                        @"cacheVideo.mp4"

// 压缩视频帧数
#define CHANGE_VIDEO_FGS                                                600

// 系统字体字号
#define UI_FONT_SIZE(size)                                              [UIFont systemFontOfSize:size]
#define UI_BOLD_FONT_SIZE(size)                                         [UIFont boldSystemFontOfSize:size]


//常用系统字号
#define UI_SYSTEM_FONT_16                                               UI_FONT_SIZE(16)
#define UI_SYSTEM_FONT_15                                               UI_FONT_SIZE(15)
#define UI_SYSTEM_FONT_14                                               UI_FONT_SIZE(14)
#define UI_SYSTEM_FONT_13                                               UI_FONT_SIZE(13)
#define UI_SYSTEM_FONT_12                                               UI_FONT_SIZE(12)
#define UI_SYSTEM_FONT_11                                               UI_FONT_SIZE(11)
#define UI_SYSTEM_FONT_10                                               UI_FONT_SIZE(10)
#define UI_SYSTEM_FONT_9                                                UI_FONT_SIZE(9)


// 常用系统加粗字号
#define UI_BOLD_SYSTEM_FONT_16                                          UI_BOLD_FONT_SIZE(16)
#define UI_BOLD_SYSTEM_FONT_15                                          UI_BOLD_FONT_SIZE(15)
#define UI_BOLD_SYSTEM_FONT_14                                          UI_BOLD_FONT_SIZE(14)
#define UI_BOLD_SYSTEM_FONT_13                                          UI_BOLD_FONT_SIZE(13)
#define UI_BOLD_SYSTEM_FONT_12                                          UI_BOLD_FONT_SIZE(12)
#define UI_BOLD_SYSTEM_FONT_11                                          UI_BOLD_FONT_SIZE(11)
#define UI_BOLD_SYSTEM_FONT_10                                          UI_BOLD_FONT_SIZE(10)
#define UI_BOLD_SYSTEM_FONT_9                                           UI_BOLD_FONT_SIZE(9)


#endif /* PublicMacroFile_h */
