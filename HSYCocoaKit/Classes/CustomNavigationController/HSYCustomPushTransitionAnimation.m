//
//  HSYCustomPushTransitionAnimation.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "HSYCustomPushTransitionAnimation.h"

@implementation HSYCustomPushTransitionAnimation

#pragma mark - Transition Animation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    [self.fromViewController.view addSubview:[self blackShadowView:MIN_ALPHA_COMPONENT]];
    [self.containerContext insertSubview:self.toViewController.view aboveSubview:self.fromViewController.view];
    @weakify(self);
    [self pushViewControllerByContextTransitioning:transitionContext animations:^{
        @strongify(self);
        [self blackShadowView:MIN_ALPHA_COMPONENT].backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:MAX_ALPHA_COMPONENT];
        self.fromViewController.view.frame = FIRST_VC_DEFAULT_FRAME;
        self.toViewController.view.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    }];
}

@end
