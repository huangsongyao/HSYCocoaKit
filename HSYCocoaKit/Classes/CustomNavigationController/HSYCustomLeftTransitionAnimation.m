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

#define MIN_ALPHA_COMPONENT                 0.0f
#define MAX_ALPHA_COMPONENT                 0.6f

@implementation HSYCustomLeftTransitionAnimation

- (instancetype)initWithTransitionType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type
{
    if (self = [super initWithTransitionDuration:DEFAULT_TRANSITION_DURATION actionsType:type]) {
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning --- Overloading

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    if (self.actionsType == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush) {
        [self toActionsAnimatedTransitioning:transitionContext];
    } else if (self.actionsType == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop) {
        [self fromActionsAnimatedTransitioning:transitionContext];
    }
}

#pragma mark - Animated Transitioning

- (void)toActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self.contextView insertSubview:self.toViewController.view aboveSubview:self.fromViewController.view];
    [self.toViewController.view setViewPoint:CGPointMake(IPHONE_WIDTH, 0)];
    [self.fromViewController.view addSubview:[self blackShadowView:MIN_ALPHA_COMPONENT]];
    self.fromViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
    @weakify(self);
    [self animatedTransitioning:transitionContext performPushMethods:YES animationForNext:^{
        @strongify(self);
        [self blackShadowView:MIN_ALPHA_COMPONENT].alpha = MAX_ALPHA_COMPONENT;
        self.fromViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8f, 0.85f);
        [self.toViewController.view setViewPoint:CGPointZero];
    }];
}

- (void)fromActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self.contextView insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];
    [self.toViewController.view addSubview:[self blackShadowView:MAX_ALPHA_COMPONENT]];
    self.toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8f, 0.85f);
    [self.fromViewController.view setViewPoint:CGPointZero];
    @weakify(self);
    [self animatedTransitioning:transitionContext performPushMethods:NO animationForNext:^{
        @strongify(self);
        [self blackShadowView:MIN_ALPHA_COMPONENT].alpha = MIN_ALPHA_COMPONENT;
        self.toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        [self.fromViewController.view setViewPoint:CGPointMake(IPHONE_WIDTH, 0)];
    }];
}

- (void)animatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext performPushMethods:(BOOL)push animationForNext:(void(^)())next
{
    @weakify(self);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (next) {
            next();
        }
    } completion:^(BOOL finished) {
        @strongify(self);
        [self removeShadow];
        if (!push) {
            if (self.tranistionFinished) {
            }
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
