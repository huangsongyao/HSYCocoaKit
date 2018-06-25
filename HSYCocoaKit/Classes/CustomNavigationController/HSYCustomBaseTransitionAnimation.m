//
//  HSYCustomBaseTransitionAnimation.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYCustomBaseTransitionAnimation.h"
#import "PublicMacroFile.h"

@implementation UIViewController (Shadow)

- (void)hsy_setShadowForColorRef:(CGColorRef)ref shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)radius
{
    self.view.layer.shadowColor = ref;
    self.view.layer.shadowOpacity = opacity;
    self.view.layer.shadowRadius = radius;
}


@end

//******************************************************************************************************

@interface HSYCustomBaseTransitionAnimation ()

@property (nonatomic, strong) UIView *shadowView;             //阴影笼罩

@end

@implementation HSYCustomBaseTransitionAnimation

- (instancetype)initWithTransitionDuration:(CGFloat)transitionDuration actionsType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type
{
    if (self = [super init]) {
        _transitionDuration = transitionDuration;
        _actionsType = type;
    }
    return self;
}

#pragma mark - Shadow View

- (UIView *)hsy_blackShadowView:(CGFloat)alpha
{
    if (!self.shadowView) {
        _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
        self.shadowView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    }
    return self.shadowView;
}

- (void)hsy_removeShadow
{
    if (self.shadowView) {
        [self.shadowView removeFromSuperview];
        self.shadowView = nil;
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.transitionDuration > 0.0f) {
        return self.transitionDuration;
    }
    return DEFAULT_TRANSITION_DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //子类中super(重载)本委托方法,父类中的本委托只会获取到相应的对象,必须在子类中重载本委托实现具体的动画效果
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor clearColor];
    _contextView = containerView;
    _fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];;
    _toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
}

#pragma mark - Gather Together

+ (kHSYCustomPercentDrivenInteractiveTransitionActionsType)hsy_togetherPercentDrivenInteractiveTransitionActionsType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type
{
    if (type == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush) {
        return kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop;
    } else if (type == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop) {
        return kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush;
    }
    return kHSYCustomPercentDrivenInteractiveTransitionActionsTypeNone;
}

#pragma mark - Animated

- (void)hsy_animatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext performPushMethods:(BOOL)push animationForNext:(void(^)(void))next
{
    @weakify(self);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (next) {
            next();
        }
    } completion:^(BOOL finished) {
        @strongify(self);
        if (@available(iOS 11.0, *)) {
            self.fromViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
            self.toViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0f, 1.0f);
        }
        [self hsy_removeShadow];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)hsy_toActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self.contextView insertSubview:self.toViewController.view aboveSubview:self.fromViewController.view];
    [self.toViewController.view setOrigin:CGPointMake(IPHONE_WIDTH, 0)];
    [self.fromViewController.view addSubview:[self hsy_blackShadowView:MIN_ALPHA_COMPONENT]];
}

- (void)hsy_fromActionsAnimatedTransitioning:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self.contextView insertSubview:self.toViewController.view belowSubview:self.fromViewController.view];
    [self.fromViewController.view setOrigin:CGPointZero];
    [self.toViewController.view addSubview:[self hsy_blackShadowView:MAX_ALPHA_COMPONENT]];
}

@end
