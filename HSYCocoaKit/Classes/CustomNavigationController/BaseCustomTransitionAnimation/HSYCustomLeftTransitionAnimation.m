//
//  HSYCustomLeftTransitionAnimation.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYCustomLeftTransitionAnimation.h"
#import "HSYBaseCustomNavigationController.h"
#import "UIView+Frame.h"
#import "HSYBaseViewController.h"

@implementation HSYCustomLeftTransitionAnimation

- (instancetype)initWithCardBackTransitionType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type
{
    if (self = [super initWithTransitionDuration:DEFAULT_TRANSITION_DURATION actionsType:type]) {
        self.hsy_transformScale = CGPointMake(0.8f, 0.85f);
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning --- Overloading

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    if (self.actionsType == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush) {
        [self hsy_toActionsAnimatedTransitioning:transitionContext];
    } else if (self.actionsType == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop) {
        [self hsy_fromActionsAnimatedTransitioning:transitionContext];
    }
}

#pragma mark - Animated Transitioning

- (void)hsy_toActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super hsy_toActionsAnimatedTransitioning:transitionContext];
    self.fromViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    @weakify(self);
    [self hsy_animatedTransitioning:transitionContext performPushMethods:YES animationForNext:^{
        @strongify(self);
        [self hsy_blackShadowView:MIN_ALPHA_COMPONENT].alpha = MAX_ALPHA_COMPONENT;
        self.fromViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.hsy_transformScale.x, self.hsy_transformScale.y);
        [self.toViewController.view setOrigin:CGPointZero];
    }];
}

- (void)hsy_fromActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super hsy_fromActionsAnimatedTransitioning:transitionContext];
    self.toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.hsy_transformScale.x, self.hsy_transformScale.y);
    @weakify(self);
    [self hsy_animatedTransitioning:transitionContext performPushMethods:NO animationForNext:^{
        @strongify(self);
        [self hsy_blackShadowView:MIN_ALPHA_COMPONENT].alpha = MIN_ALPHA_COMPONENT;
        self.toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        [self.fromViewController.view setOrigin:CGPointMake(IPHONE_WIDTH, 0)];
    }];
}


@end
