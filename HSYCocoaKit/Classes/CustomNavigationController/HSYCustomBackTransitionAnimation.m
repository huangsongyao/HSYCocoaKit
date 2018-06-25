//
//  HSYCustomBackTransitionAnimation.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/25.
//

#import "HSYCustomBackTransitionAnimation.h"

@implementation HSYCustomBackTransitionAnimation

- (instancetype)initWithSystemBackTransitionType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type
{
    if (self = [super initWithTransitionDuration:DEFAULT_TRANSITION_DURATION actionsType:type]) {
        self.hsy_leftTransitionOffset = IPHONE_WIDTH/3;
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

- (void)hsy_toActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super hsy_toActionsAnimatedTransitioning:transitionContext];
    self.fromViewController.view.origin = CGPointZero;
    @weakify(self);
    [self hsy_animatedTransitioning:transitionContext performPushMethods:YES animationForNext:^{
        @strongify(self);
        [self hsy_blackShadowView:MIN_ALPHA_COMPONENT].alpha = MAX_ALPHA_COMPONENT;
        self.fromViewController.view.origin = CGPointMake(-self.hsy_leftTransitionOffset, 0.0f);
        [self.toViewController.view setOrigin:CGPointZero];
    }];
}

- (void)hsy_fromActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super hsy_fromActionsAnimatedTransitioning:transitionContext];
    self.toViewController.view.origin = CGPointMake(-self.hsy_leftTransitionOffset, 0.0f);
    @weakify(self);
    [self hsy_animatedTransitioning:transitionContext performPushMethods:NO animationForNext:^{
        @strongify(self);
        [self hsy_blackShadowView:MIN_ALPHA_COMPONENT].alpha = MIN_ALPHA_COMPONENT;
        self.toViewController.view.origin = CGPointZero;
        [self.fromViewController.view setOrigin:CGPointMake(IPHONE_WIDTH, 0)];
    }];
}

@end
