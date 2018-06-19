//
//  UIViewController+Finder.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Finder)

/**
 寻找并返回当前设备在屏幕上所显示的控制器的对象

 @return 当前显示于屏幕上的控制器
 */
+ (UIViewController *)currentViewController;

@end
