//
//  UIResponder+Orientation.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/24.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Orientation)

/**
 控制横竖屏的标识位，可以和“+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation”方法一起配合使用，一起使用时，“- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window”委托中根据hsy_landscapeInterfaceOrientation的状态来判断返回的横竖屏状态
 */
@property (nonatomic, strong) NSNumber *hsy_landscapeInterfaceOrientation;

/**
 控制横竖屏的方向枚举，请和“- (void)landscapeDirection:(BOOL)landscape”方法一起使用，默认为nil，当“- (void)landscapeDirection:(BOOL)landscape”被调用时，本属性会根据landscape做动态设置为UIInterfaceOrientationPortrait（NO）或UIInterfaceOrientationLandscapeRight（YES），并且请在“- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window”委托中返回本属性
 */
@property (nonatomic, strong) NSNumber *hsy_landscapeDirection;


/**
 强制横竖屏实现，必须在AppDelegate中实现“- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window”委托，当本方法被调用时，该委托会被触发
 
 @param orientation 横屏枚举
 */
+ (void)interfaceOrientation:(UIInterfaceOrientation)orientation;

/**
 控制横竖屏，为YES时，设置为横屏方法，为NO时，设置为竖屏，必须在AppDelegate中实现“- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window”委托，并返回“hsy_landscapeDirection”

 @param landscape YES表示横屏，NO表示竖屏
 */
- (void)landscapeDirection:(BOOL)landscape;

@end
