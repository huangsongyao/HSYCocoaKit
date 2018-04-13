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
    
    kHSYCocoaKitLaunchScreenSize_3_5_Inch   = 480,  //iPhone4、4s
    kHSYCocoaKitLaunchScreenSize_4_0_Inch   = 568,  //iPhone5、5s
    kHSYCocoaKitLaunchScreenSize_4_7_Inch   = 667,  //iPhone6、6s、7、7s、8
    kHSYCocoaKitLaunchScreenSize_5_5_Inch   = 736,  //iPhone6 Plus、6s Plus
    kHSYCocoaKitLaunchScreenSize_5_8_Inch   = 812,  //iPhoneX
    
};

@interface HSYBaseLaunchScreenViewController : UIViewController

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

@end
