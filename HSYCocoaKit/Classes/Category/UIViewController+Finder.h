//
//  UIViewController+Finder.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Finder)

/**
 通过控制器的类名寻找栈控制器中是否存在，有则返回该控制器对象，否则返回nil

 @param className 控制器类名
 @return UIViewController
 */
- (UIViewController *)finderNavigationControllersSubViewControllerByClassName:(NSString *)className;

/**
 寻找并返回当前设备在屏幕上所显示的控制器的对象

 @return 当前显示于屏幕上的控制器
 */
+ (UIViewController *)currentViewController;

@end
