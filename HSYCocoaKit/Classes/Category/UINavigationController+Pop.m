//
//  UINavigationController+Pop.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import "UINavigationController+Pop.h"

@implementation UINavigationController (Pop)

- (void)hsy_popAnimatedViewController:(NSString *)viewControllerName
{
    [self hsy_popViewController:viewControllerName animated:YES];
}

- (void)hsy_popViewController:(NSString *)viewControllerName animated:(BOOL)animated
{
    UIViewController *viewController = [self finderViewController:viewControllerName];
    if (viewController) {
        [self popToViewController:viewController animated:animated];
    }
}

- (UIViewController *)finderViewController:(NSString *)className
{
    UIViewController *viewController = nil;
    for (UIViewController *vc in self.viewControllers) {
        if ([className isEqualToString:NSStringFromClass(vc.class)]) {
            viewController = vc;
            break;
        }
    }
    return viewController;
}

@end
