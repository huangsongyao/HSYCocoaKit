//
//  HSYBaseCustomTransitionAnimation.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "HSYBaseCustomTransitionAnimation.h"

#define DEFAULT_ANIMATION_DURATION          0.30f

@interface HSYBaseCustomTransitionAnimation ()

@property (nonatomic, strong) UIView *shadowView;             //阴影笼罩

@end

@implementation HSYBaseCustomTransitionAnimation

#pragma mark - UIViewControllerAnimatedTransitioning
#pragma mark - Transition Duration

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.animationDuration > 0.0f) {
        return self.animationDuration;
    }
    return DEFAULT_ANIMATION_DURATION;
}

#pragma mark - UIViewControllerAnimatedTransitioning
#pragma mark - Transition Animation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //子类中super本委托方法,父类中的本委托只会获取到相应的对象,必须在子类中重载本委托实现具体的动画效果
    self.containerContext = [NSObject containerViewByTransition:transitionContext];
    self.fromViewController = [NSObject fromViewControllerByTransition:transitionContext];
    self.toViewController = [NSObject toViewControllerByTransition:transitionContext];
    
    return;
}

#pragma mark - Shadow View

- (UIView *)blackShadowView:(CGFloat)alpha
{
    if (!self.shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
        self.shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    }
    return self.shadowView;
}

#pragma mark - Animation

- (void)pushViewControllerByContextTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext animations:(void(^)())animations
{
    @weakify(self);
    //push动作下，self.toViewController指针指向的是即将要push出现的控制器
    [self pushToViewController:self.toViewController transitionDuration:[self transitionDuration:transitionContext] animations:^{
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        @strongify(self);
        [self.shadowView removeFromSuperview];
        self.shadowView = nil;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)popViewControllerByContextTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext animations:(void(^)())animations
{
    @weakify(self);
    //pop动作下，self.toViewController指针指向的是即将要pop回去的控制器
    [self popFromViewController:self.toViewController transitionDuration:[self transitionDuration:transitionContext] animations:^{
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        @strongify(self);
        [self.shadowView removeFromSuperview];
        self.shadowView = nil;
        self.toViewController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.toViewController.view.frame), CGRectGetHeight(self.toViewController.view.frame));
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
