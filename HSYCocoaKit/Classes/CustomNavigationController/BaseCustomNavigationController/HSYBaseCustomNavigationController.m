//
//  HSYBaseCustomNavigationController.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYBaseCustomNavigationController.h"
#import "HSYBaseViewController.h"
#import "HSYCustomBackTransitionAnimation.h"

@interface HSYBaseCustomNavigationController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation HSYBaseCustomNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController params:(NSDictionary <NSNumber *, id>*)params
{
    if (self = [super initWithRootViewController:rootViewController]) {
        _banTransition = NO;
        _panGestureEndedProgress = (params[@(kHSYCustomNavigationControllerParamsKeyEndedProgress)] ? ([params[@(kHSYCustomNavigationControllerParamsKeyEndedProgress)] floatValue]) : 0.45);
        _animation = (params[@(kHSYCustomNavigationControllerParamsKeyAnimationType)] ? (kHSYCustomNavigationControllerPushAnimation)[params[@(kHSYCustomNavigationControllerParamsKeyAnimationType)] integerValue] : kHSYCustomNavigationControllerPushAnimationSystemPush);
        self.openTransitionAnimation = (params[@(kHSYCustomNavigationControllerParamsKeyOpenTransitionAnimation)] ? [params[@(kHSYCustomNavigationControllerParamsKeyOpenTransitionAnimation)] boolValue] : YES);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (VERSION_GTR_IOS8) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    // Do any additional setup after loading the view.
}

#pragma mark - Setter

- (void)openCustomTransitionAnimation:(BOOL)openTransitionAnimation
{
    _openTransitionAnimation = openTransitionAnimation;
    if (openTransitionAnimation) {
        self.delegate = self;
        self.navigationBar.hidden = YES;
        self.navigationBar.backItem.hidesBackButton = YES;
        self.interactivePopGestureRecognizer.enabled = NO;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(hsy_handlePopRecognizer:)];
        panGesture.delegate = self;
        [self.view addGestureRecognizer:panGesture];
    }
}

#pragma mark - Pan Gesture Handle

- (void)hsy_handlePopRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint point = [recognizer translationInView:recognizer.view];
    CGFloat progress = point.x / recognizer.view.bounds.size.width;
    progress = MIN(1.0f, MAX(0.0f, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        [self.interactivePopTransition updateInteractiveTransition:progress];
    } else if (recognizer.state == UIGestureRecognizerStateEnded ||
               recognizer.state == UIGestureRecognizerStateCancelled) {
        _tranistionCompleted = (progress >= self.panGestureEndedProgress);
        if (self.tranistionCompleted) {
            [self.interactivePopTransition finishInteractiveTransition];
        } else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        self.interactivePopTransition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        HSYCustomBaseTransitionAnimation *push = [self hsy_pushTransitionAnimation];
        return push;
    } else if (operation == UINavigationControllerOperationPop) {
        HSYCustomBaseTransitionAnimation *pop = [self hsy_popTransitionAnimation];
        return pop;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[HSYCustomBaseTransitionAnimation class]]) {
        HSYCustomBaseTransitionAnimation *pop = (HSYCustomBaseTransitionAnimation *)animationController;
        if (pop.actionsType == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop) {
            return self.interactivePopTransition;
        }
    }
    return nil;
}

- (HSYCustomBaseTransitionAnimation *)hsy_pushTransitionAnimation
{
    HSYCustomBaseTransitionAnimation *animation = nil;
    if (self.animation == kHSYCustomNavigationControllerPushAnimationCardPush) {
        animation = [[HSYCustomLeftTransitionAnimation alloc] initWithCardBackTransitionType:kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush];
    } else if (self.animation == kHSYCustomNavigationControllerPushAnimationSystemPush) {
        animation = [[HSYCustomBackTransitionAnimation alloc] initWithSystemBackTransitionType:kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush];
    }
    return animation;
}

- (HSYCustomBaseTransitionAnimation *)hsy_popTransitionAnimation
{
    HSYCustomBaseTransitionAnimation *animation = nil;
    if (self.animation == kHSYCustomNavigationControllerPushAnimationCardPush) {
        animation = [[HSYCustomLeftTransitionAnimation alloc] initWithCardBackTransitionType:kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop];
    } else if (self.animation == kHSYCustomNavigationControllerPushAnimationSystemPush) {
        animation = [[HSYCustomBackTransitionAnimation alloc] initWithSystemBackTransitionType:kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop];
    }
    return animation;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.banTransition) {
        return NO;
    }
    return ((self.viewControllers.count > 1) ? YES : NO);
}

#pragma mark - Overloading

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    return [super popViewControllerAnimated:animated];
}

#pragma mark - StatusBar Style

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
