//
//  PublicMacroFile.h
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#ifndef PublicMacroFile_h
#define PublicMacroFile_h

//"-Wmismatched-parameter-types"去除类型警告；"-Wstrict-prototypes"去除block的This block declaration is not a prototype警告
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wmismatched-parameter-types"
//#pragma clang diagnostic ignored "-Wstrict-prototypes"
//#pragma clang diagnostic pop

#import "UIApplication+Device.h"
#import "HSYBaseLaunchScreenViewController.h"
#import "NSBundle+CFBundle.h"
#import "NSFileManager+Finder.h"

//debug模式下的NSLog
#ifdef DEBUG

#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)

#else

#define NSLog(...)
#define debugMethod()

#endif


//简化CGPoint、CGSize、CGRect的NSLog
#define NSLogPoint(point)           NSLog(@"{\n x=%f, y=%f}", point.x, point.y)
#define NSLogSize(size)             NSLog(@"{\n width=%f, height=%f}", size.width, size.height)
#define NSLogRect(rect)             NSLog(@"{\n x=%f, y=%f, width=%f, height=%f}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)


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


//statusBar高度
#define IPHONE_STATE_BAR_HEIGHT                                         IPHONE_STATUS_BAR_HEIGHT
//导航栏的header高度
#define IPHONE_NAVIGATION_BAR_HEIGHT                                    (44.0f)
//导航栏高度
#define IPHONE_BAR_HEIGHT                                               (IPHONE_STATE_BAR_HEIGHT + IPHONE_NAVIGATION_BAR_HEIGHT)
//tableView扣除导航栏后的高度
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
#define RANDOM_RGBA(alpha) RGBA((arc4random()%256), (arc4random()%256), (arc4random()%256), alpha)
#define RANDOM_RGB  RANDOM_RGBA(1.0f)


//展示页的宏
#define SHOWIMAGE(ver)                                                  SHPWVC_BG(ver)


//获取文件路径
#define GET_FILES_PATH(name, type)                                      [NSFileManager finderFileFromName:name fileType:type]


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
#define APP_INFO_TARGET_NAME                            [NSBundle hsy_appBundleTargetName]


//角度转弧度
#define DEGREES_TO_RADIANS(angle)                       (angle * M_PI / 180.0f)
//弧度转角度
#define RADIANS_TO_DEGREES(radian)                      ((radian * 180.0f) / M_PI)


//设备类型，真机或者模拟器
#ifndef TARGET_DEVICE_IS_OS_IPHONE
#if TARGET_IPHONE_SIMULATOR
#define TARGET_DEVICE_IS_OS_IPHONE  NO
#elif TARGET_OS_IPHONE
#define TARGET_DEVICE_IS_OS_IPHONE  YES
#endif
#endif


//CGAffineTransformIdentity格式的放缩
#define HSYCOCOAKIT_GGA_TRANSFORM_SCALES(scale1, scale2)                              (CGAffineTransformScale(CGAffineTransformIdentity, scale1, scale2))
#define HSYCOCOAKIT_GGA_TRANSFORM_SCALE(scale)              HSYCOCOAKIT_GGA_TRANSFORM_SCALES(scale, scale)


//绕圆心的旋转动画
#define HSYCOCOAKIT_GGA_ROTATION(angle)                     (CGAffineTransformMakeRotation(angle))


//3D平移，toX表示平面从设备左-->右的平移方向的值[正值表示向右平移，负值表示向左平移]，toY表示平面从设备顶部-->底部的平移方向的值[正值表示向下，负值表示向上]，toZ表示平面从设备面-->视觉面的平移方向的值[正值表示靠近视觉平面，负值表示远离视觉平面]
#define HSYCOCOAKIT_GGA_3D_TRANSLATION(toX, toY, toZ)       (CATransform3DMakeTranslation(toX, toY, toZ))
#define HSYCOCOAKIT_GGA_3D_TRANSLATION_TO_X_AXLE(toX)       (HSYCOCOAKIT_GGA_3D_TRANSLATION(toX, 0, 0))
#define HSYCOCOAKIT_GGA_3D_TRANSLATION_TO_Y_AXLE(toY)       (HSYCOCOAKIT_GGA_3D_TRANSLATION(0, toY, 0))
#define HSYCOCOAKIT_GGA_3D_TRANSLATION_TO_Z_AXLE(toZ)       (HSYCOCOAKIT_GGA_3D_TRANSLATION(0, 0, toZ))


//3D旋转，CATransform3D_t表示传入一个CATransform3D的3D矩阵的结构体，angle表示旋转角度，宏会自动转为弧度，rotateX、rotateY和rotateZ的取值为0和1，0表示此轴不做旋转，1表示此轴做旋转，则三个参数分别表示“是否在x轴做旋转”、“是否在y轴做旋转”以及“是否在z轴做旋转”，并且旋转方式为绕中轴旋转
#define HSYCOCOAKIT_GGA_3D_ROTATE(CATransform3D_t, angle, rotateX, rotateY, rotateZ)       (CATransform3DRotate(CATransform3D_t, DEGREES_TO_RADIANS(angle), rotateX, rotateY, rotateZ))
#define HSYCOCOAKIT_GGA_3D_ROTATE_X_AXLE(CATransform3D_t, rotateX)      (HSYCOCOAKIT_GGA_3D_ROTATE(CATransform3D_t, rotateX, 0, 0))
#define HSYCOCOAKIT_GGA_3D_ROTATE_Y_AXLE(CATransform3D_t, rotateY)      (HSYCOCOAKIT_GGA_3D_ROTATE(CATransform3D_t, 0, rotateY, 0))
#define HSYCOCOAKIT_GGA_3D_ROTATE_Z_AXLE(CATransform3D_t, rotateZ)      (HSYCOCOAKIT_GGA_3D_ROTATE(CATransform3D_t, 0, 0, rotateZ))


//3D放缩，CATransform3D_t表示传入一个CATransform3D的3D矩阵的结构体，scaleX表示在x轴上的放缩，scaleY表示在y轴上的放缩，scaleZ表示在z轴上的放缩
#define HSYCOCOAKIT_GGA_3D_SCALE(CATransform3D_t, scaleX, scaleY, scaleZ)       (CATransform3DScale(CATransform3D_t, scaleX, scaleY, scaleZ))

//忽略"-Warc-performSelector-leaks"警告，“- performSelector:”类型的方法请不加“;”作为“stuff”参数写在“()”中
#define HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING(stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#endif /* PublicMacroFile_h */
