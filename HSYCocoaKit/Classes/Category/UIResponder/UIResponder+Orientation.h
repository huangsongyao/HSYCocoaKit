//
//  UIResponder+Orientation.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/24.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Orientation)

/**
 控制横竖屏的标识位
 */
@property (nonatomic, strong) NSNumber *hsy_landscapeInterfaceOrientation;

/**
 横屏实现，必须在AppDelegate中实现- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window委托，当本方法被调用时，该委托会被触发
 
 @param orientation 横屏枚举
 */
+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation;

@end
