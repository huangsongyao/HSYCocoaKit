//
//  NSObject+Context.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface NSObject (Context)

/**
 *  获取转场的容器上下文
 *
 *  @param transitionContext 委托的上下文
 *
 *  @return 容器视图
 */
+ (UIView *)containerViewByTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

/**
 *  获取转场 “前” 的视图
 *
 *  @param transitionContext 委托的上下文
 *
 *  @return 转场 “前” 视图控制器
 */
+ (UIViewController *)fromViewControllerByTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

/**
 *  获取转场 “后” 的视图
 *
 *  @param transitionContext 委托的上下文
 *
 *  @return 转场 “后” 视图控制器
 */
+ (UIViewController *)toViewControllerByTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
