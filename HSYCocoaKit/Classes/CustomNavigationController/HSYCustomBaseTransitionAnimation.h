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
#import "UIViewController+Shadow.h"

#define DEFAULT_TRANSITION_DURATION                     0.5f

typedef NS_ENUM(NSUInteger, kHSYCustomPercentDrivenInteractiveTransitionActionsType) {
    
    kHSYCustomPercentDrivenInteractiveTransitionActionsTypeNone,
    kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush,                        //push动作
    kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop,                         //pop动作
    
};

@interface HSYCustomBaseTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, strong, readonly) UIView *contextView;                                                      //上下文容器
@property (nonatomic, strong, readonly) UIViewController *toViewController;                                                 //push或者pop动作的对象视图
@property (nonatomic, strong, readonly) UIViewController *fromViewController;                                               //push或者pop动作即将移除或者被覆盖的视图

@property (nonatomic, assign, readonly) kHSYCustomPercentDrivenInteractiveTransitionActionsType actionsType;
@property (nonatomic, assign, readonly) CGFloat transitionDuration;

- (instancetype)initWithTransitionDuration:(CGFloat)transitionDuration
                               actionsType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type NS_AVAILABLE_IOS(8_0);
+ (kHSYCustomPercentDrivenInteractiveTransitionActionsType)hsy_togetherPercentDrivenInteractiveTransitionActionsType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type NS_AVAILABLE_IOS(8_0);
- (UIView *)hsy_blackShadowView:(CGFloat)alpha;
- (void)hsy_removeShadow;

@end
