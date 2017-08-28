//
//  HSYNavigationController.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "HSYNavigationController.h"
#import "HSYCustomPopTransitionAnimation.h"
#import "HSYCustomPushTransitionAnimation.h"

@interface HSYNavigationController ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;

@end

@implementation HSYNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    if (VERSION_GTR_IOS8) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.fullScreenPop = YES;
    self.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(nonnull UIViewController *)toVC
{
    if (self.fullScreenPop) {
        switch (operation) {
            case UINavigationControllerOperationPush: {
                HSYCustomPushTransitionAnimation *pushTransitionAnimation = [HSYCustomPushTransitionAnimation new];
                pushTransitionAnimation.animationDuration = self.animationDuration;
                return pushTransitionAnimation;
            }
                break;
                
            case UINavigationControllerOperationPop: {
                HSYCustomPopTransitionAnimation *popTransitionAnimation = [HSYCustomPopTransitionAnimation new];
                popTransitionAnimation.animationDuration = self.animationDuration;
                return popTransitionAnimation;
            }
                break;
            default:
                break;
        }
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (self.fullScreenPop) {
        HSYCustomPopTransitionAnimation *popTransitionAnimation = [HSYCustomPopTransitionAnimation new];
        if ([animationController isKindOfClass:[popTransitionAnimation class]]) {
            return self.percentDrivenInteractiveTransition;
        }
    }
    return nil;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return (self.viewControllers.count > 1) ? YES : NO;
}

#pragma mark - Set GestureRecognizer

- (void)setFullScreenPop:(BOOL)fullScreenPop
{
    _fullScreenPop = fullScreenPop;
    if (fullScreenPop) {
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)];
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:panGestureRecognizer];
    }
}

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:gesture.view];
    CGFloat progress = point.x / gesture.view.bounds.size.width;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self popViewControllerAnimated:YES];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenInteractiveTransition updateInteractiveTransition:progress];
    } else if (gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateEnded) {
        //判断手势滑动距离是否超过屏幕的一半，如果超过一半则完成pop动画
        if (progress > 0.5) {
            [self.percentDrivenInteractiveTransition finishInteractiveTransition];
        } else {
            [self.percentDrivenInteractiveTransition cancelInteractiveTransition];
        }
        self.percentDrivenInteractiveTransition = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
