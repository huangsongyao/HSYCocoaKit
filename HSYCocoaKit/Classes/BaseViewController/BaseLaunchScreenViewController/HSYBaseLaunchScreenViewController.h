//
//  HSYBaseLaunchScreenViewController.h
//  Pods
//
//  Created by huangsongyao on 2018/4/13.
//
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitLaunchScreenSize) {
    
    kHSYCocoaKitLaunchScreenSize_3_5_Inch   = 960,                      //iPhone4、4s
    kHSYCocoaKitLaunchScreenSize_4_0_Inch   = 1136,                     //iPhone5、5s
    kHSYCocoaKitLaunchScreenSize_4_7_Inch   = 1334,                     //iPhone6、6s、7、7s、8
    kHSYCocoaKitLaunchScreenSize_5_5_Amplify_Inch       = 2001,         //iPhone6 Plus、6s Plus放大版
    kHSYCocoaKitLaunchScreenSize_5_5_Physically_Inch    = 1920,         //iPhone6 Plus、6s Plus物理版
    kHSYCocoaKitLaunchScreenSize_5_5_Inch   = 2208,                     //iPhone6 Plus、6s Plus通用版
    kHSYCocoaKitLaunchScreenSize_5_8_Inch   = 2436,                     //iPhoneX、iPhoneXS
    kHSYCocoaKitLaunchScreenSize_6_1_Inch   = 1792,                     //iPhoneXR
    kHSYCocoaKitLaunchScreenSize_6_5_Inch   = 2688,                     //iPhoneXS Max
    
};

@interface HSYBaseLaunchScreenViewController : UIViewController

@property (nonatomic, strong) UIImage *placeholderImage;

/**
 初始化，入参格式为：@{
                    @(kHSYCocoaKitLaunchScreenSize_3_5_Inch) : @"kHSYCocoaKitLaunchScreenSize_3_5_Inch对应的尺寸的启动图",
                    @(kHSYCocoaKitLaunchScreenSize_4_0_Inch) : @"kHSYCocoaKitLaunchScreenSize_4_0_Inch对应的尺寸的启动图",
                    @(kHSYCocoaKitLaunchScreenSize_4_7_Inch) : @"kHSYCocoaKitLaunchScreenSize_4_7_Inch对应的尺寸的启动图",
                    @(kHSYCocoaKitLaunchScreenSize_5_5_Inch) : @"kHSYCocoaKitLaunchScreenSize_5_5_Inch对应的尺寸的启动图",
                    @(kHSYCocoaKitLaunchScreenSize_5_8_Inch) : @"kHSYCocoaKitLaunchScreenSize_5_8_Inch对应的尺寸的启动图"
                    },

 @param launchScreens 启动页的参数
 @param network RACSignal信号的网络请求
 @parma next 请求结果的回调，成功则返回sendNext，否则返回sendError；成功时可以直接在next中获取的appDelegate的window层的rootViewController进行重置。
 @return self
 */
+ (instancetype)initWithLaunchScreens:(NSDictionary<NSNumber *,NSString *> *)launchScreens
                        networkSiganl:(RACSignal *)network
                       subscriberNext:(void(^)(id sendNext, id<UIApplicationDelegate> appDelegate, NSError *sendError))next;

/**
 初始化，传入完整的网络图片的远端地址和首个配置请求

 @param urlString 用于显示的远端图片地址
 @param network 首个配置请求
 @param next 请求回调事件
 @return self
 */
+ (instancetype)initWithRequestLaunchScreens:(NSString *)urlString
                               networkSiganl:(RACSignal *)network
                              subscriberNext:(void(^)(id sendNext, id<UIApplicationDelegate> appDelegate, NSError *sendError))next;

/**
 判断是否为iPhoneX设备

 @return YES or NO
 */
+ (BOOL)iPhoneXDevice;

/**
 返回当前设备的尺寸枚举类型

 @return 当前设备的尺寸枚举类型
 */
+ (kHSYCocoaKitLaunchScreenSize)iPhoneDeviceScreen;

@end
