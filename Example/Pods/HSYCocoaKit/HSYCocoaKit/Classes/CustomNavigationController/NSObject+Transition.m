//
//  NSObject+Transition.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSObject+Transition.h"
#import "PublicMacroFile.h"
#import "UIViewController+Shadow.h"

#define DEFAULT_COLOR_REF   [[UIColor blackColor] CGColor]
#define DEFAULT_OPACITY     0.75f
#define DEFAULT_RADIUS      8.0f

@implementation NSObject (Transition)

#pragma mark - Pop

+ (void)popFromViewController:(UIViewController *)viewController transitionDuration:(NSTimeInterval)duration shadowBlock:(void(^)())block animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    //设置pop回去的控制器的视图的初始位置和大小
    viewController.view.frame = FIRST_VC_DEFAULT_FRAME;
    //fromViewController.view添加阴影
    if (block) {
        block();
    }
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)popFromViewController:(UIViewController *)viewController transitionDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    [self.class popFromViewController:viewController transitionDuration:duration shadowBlock:^{
        if (viewController) {
            [viewController setShadowForColorRef:DEFAULT_COLOR_REF shadowOpacity:DEFAULT_OPACITY shadowRadius:DEFAULT_RADIUS];
        }
    } animations:animations completion:completion];
}

#pragma mark - Push

+ (void)pushToViewController:(UIViewController *)viewController transitionDuration:(NSTimeInterval)duration shadowBlock:(void(^)())block animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    //设置push出现的控制器的视图的初始位置和大小
    viewController.view.frame = CGRectMake(IPHONE_WIDTH, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    //toViewController.view添加阴影
    if (block) {
        block();
    }
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)pushToViewController:(UIViewController *)viewController transitionDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion
{
    [self.class pushToViewController:viewController transitionDuration:duration shadowBlock:^{
        if (viewController) {
            [viewController setShadowForColorRef:DEFAULT_COLOR_REF shadowOpacity:DEFAULT_OPACITY shadowRadius:DEFAULT_RADIUS];
        }
    } animations:animations completion:completion];
}

@end
