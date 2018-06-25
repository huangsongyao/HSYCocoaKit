//
//  HSYCustomBaseTransitionAnimation.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+Frame.h"
#import "ReactiveCocoa.h"
#import "PublicMacroFile.h"

#define DEFAULT_TRANSITION_DURATION                     0.5f
#define MIN_ALPHA_COMPONENT                             0.0f
#define MAX_ALPHA_COMPONENT                             0.6f

typedef NS_ENUM(NSUInteger, kHSYCustomPercentDrivenInteractiveTransitionActionsType) {
    
    kHSYCustomPercentDrivenInteractiveTransitionActionsTypeNone,
    kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush,                        //push动作
    kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop,                         //pop动作
    
};

@interface UIViewController (Shadow)

/**
 设置layer层的阴影效果
 
 @param ref     阴影颜色
 @param opacity 透明度
 @param radius  圆角
 */
- (void)hsy_setShadowForColorRef:(CGColorRef)ref shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius;

@end

@interface HSYCustomBaseTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong, readonly) UIView *contextView;                                                      //上下文容器
@property (nonatomic, strong, readonly) UIViewController *toViewController;                                                 //push或者pop动作的对象视图
@property (nonatomic, strong, readonly) UIViewController *fromViewController;                                               //push或者pop动作即将移除或者被覆盖的视图

@property (nonatomic, assign, readonly) kHSYCustomPercentDrivenInteractiveTransitionActionsType actionsType;
@property (nonatomic, assign, readonly) CGFloat transitionDuration;

- (instancetype)initWithTransitionDuration:(CGFloat)transitionDuration
                               actionsType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 用于push和pop枚举轮转的类方法

 @param type kHSYCustomPercentDrivenInteractiveTransitionActionsType枚举
 @return 根据枚举类型轮转
 */
+ (kHSYCustomPercentDrivenInteractiveTransitionActionsType)hsy_togetherPercentDrivenInteractiveTransitionActionsType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 创建阴影效果的透明度的视图

 @param alpha alpha通道值
 @return 阴影效果的透明度的视图
 */
- (UIView *)hsy_blackShadowView:(CGFloat)alpha;

/**
 移除阴影效果
 */
- (void)hsy_removeShadow;

/**
 过度动画，“- hsy_toActionsAnimatedTransitioning”和“- hsy_fromActionsAnimatedTransitioning”会调用到本方法，开放接口以防定制需求

 @param transitionContext 转场的上下文承接容器
 @param push YES为push，NO为pop
 @param next 动画内容的block回调
 */
- (void)hsy_animatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext performPushMethods:(BOOL)push animationForNext:(void(^)(void))next;

/**
 push动画定制，子类请重载本方法，及调用[super hsy_toActionsAnimatedTransitioning:transitionContext]

 @param transitionContext 转场的上下文承接容器
 */
- (void)hsy_toActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext;

/**
 pop动画定制，子类请重载本方法，及调用[super hsy_fromActionsAnimatedTransitioning:transitionContext]

 @param transitionContext 转场的上下文承接容器
 */
- (void)hsy_fromActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext;

@end
