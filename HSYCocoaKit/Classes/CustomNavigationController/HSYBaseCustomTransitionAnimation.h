//
//  HSYBaseCustomTransitionAnimation.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>
#import "PublicMacroFile.h"
#import "NSObject+Context.h"
#import "NSObject+Transition.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface HSYBaseCustomTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval animationDuration;         //转场动画时间

@property (nonatomic, strong) UIView *containerContext;                 //转场容器所在的视图
@property (nonatomic, strong) UIViewController *fromViewController;     //转场 “前” 的视图控制器
@property (nonatomic, strong) UIViewController *toViewController;       //转场 “后” 的视图控制器

- (UIView *)blackShadowView:(CGFloat)alpha;
- (void)pushViewControllerByContextTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext animations:(void(^)())animations;
- (void)popViewControllerByContextTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext animations:(void(^)())animations;

@end
