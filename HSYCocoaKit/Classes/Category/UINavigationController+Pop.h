//
//  UINavigationController+Pop.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Pop)

/**
 pop到指定的vc层

 @param viewControllerName 要pop回去的vc控制器
 @param animated 是否执行动画
 */
- (void)hsy_popViewController:(NSString *)viewControllerName animated:(BOOL)animated;

/**
 pop到指定的vc层，默认执行动画效果

 @param viewControllerName 要pop回去的vc控制器
 */
- (void)hsy_popAnimatedViewController:(NSString *)viewControllerName;

@end
