//
//  HSYCustomPopTransitionAnimation.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "HSYCustomPopTransitionAnimation.h"

@implementation HSYCustomPopTransitionAnimation

#pragma mark - Transition Animation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [super animateTransition:transitionContext];
    [self.toViewController.view addSubview:[self blackShadowView:MAX_ALPHA_COMPONENT]];
    [self.containerContext insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];
    @weakify(self);
    [self popViewControllerByContextTransitioning:transitionContext animations:^{
        @strongify(self);
        [self blackShadowView:MAX_ALPHA_COMPONENT].backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:MIN_ALPHA_COMPONENT];
        self.fromViewController.view.frame = CGRectMake(IPHONE_WIDTH, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
        self.toViewController.view.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    }];
}


@end
