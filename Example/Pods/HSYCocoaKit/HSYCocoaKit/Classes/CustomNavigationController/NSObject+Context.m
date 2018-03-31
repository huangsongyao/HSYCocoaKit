//
//  NSObject+Context.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSObject+Context.h"

@implementation NSObject (Context)

+ (UIView *)containerViewByTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取转场容器
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor blackColor];
    return containerView;
}

+ (UIViewController *)fromViewControllerByTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取转场前的界面视图
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    return fromViewController;
}

+ (UIViewController *)toViewControllerByTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取转场后的界面视图
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    return toViewController;
}

@end
