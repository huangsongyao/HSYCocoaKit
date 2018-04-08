//
//  HSYBaseCustomNavigationController.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYBaseCustomNavigationController.h"

@interface HSYBaseCustomNavigationController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@end

@implementation HSYBaseCustomNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController params:(NSDictionary <NSNumber *, id>*)params
{
    if (self = [super initWithRootViewController:rootViewController]) {
        _panGestureEndedProgress = (params[@(kHSYCustomNavigationControllerParamsKeyEndedProgress)] ? ([params[@(kHSYCustomNavigationControllerParamsKeyEndedProgress)] floatValue]) : 0.65);
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
        self.interactivePopGestureRecognizer.enabled = NO;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
        panGesture.delegate = self;
        [self.view addGestureRecognizer:panGesture];
    }
}

#pragma mark - Pan Gesture Handle

- (void)handlePopRecognizer:(UIPanGestureRecognizer *)recognizer
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
        HSYCustomLeftTransitionAnimation *push = [[HSYCustomLeftTransitionAnimation alloc] initWithTransitionType:kHSYCustomPercentDrivenInteractiveTransitionActionsTypePush];
        return push;
    } else if (operation == UINavigationControllerOperationPop) {
        HSYCustomLeftTransitionAnimation *pop = [[HSYCustomLeftTransitionAnimation alloc] initWithTransitionType:kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop];
        pop.tranistionFinished = self.tranistionCompleted;
        return pop;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if ([animationController isKindOfClass:[HSYCustomLeftTransitionAnimation class]]) {
        HSYCustomLeftTransitionAnimation *pop = (HSYCustomLeftTransitionAnimation *)animationController;
        if (pop.actionsType == kHSYCustomPercentDrivenInteractiveTransitionActionsTypePop) {
            return self.interactivePopTransition;
        }
    }
    return nil;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return ((self.viewControllers.count > 1) ? YES : NO);
}

#pragma mark - Overloading

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    _tranistionCompleted = YES;
    return [super popViewControllerAnimated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
