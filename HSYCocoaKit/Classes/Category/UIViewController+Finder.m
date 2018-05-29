//
//  UIViewController+Finder.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import "UIViewController+Finder.h"

@implementation UIViewController (Finder)

#pragma mark - Finder NavigationController SubViewController

- (UIViewController *)finderNavigationControllersSubViewControllerByClassName:(NSString *)className
{
    return [self.class finderNavigationControllersSubViewControllerByClassName:className andViewControllers:self.navigationController.viewControllers];
}

+ (UIViewController *)finderNavigationControllersSubViewControllerByClassName:(NSString *)className andViewControllers:(NSArray *)viewControllers
{
    if (className.length == 0) {
        return nil;
    }
    for (UIViewController *viewController in viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}

#pragma mark - Finder Device Screen ViewController

+ (UIViewController *)currentViewController
{
    UIViewController *rootViewController = [self.class rootCurrentViewController];
    UIViewController *currentViewController = [self.class finderBestViewController:rootViewController];
    return currentViewController;
}

+ (UIViewController *)finderBestViewController:(UIViewController *)viewController
{
    if (viewController.presentedViewController) {
        return [self.class finderBestViewController:viewController.presentedViewController];
    } else if ([viewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController *)viewController;
        if (svc.viewControllers.count > 0) {
            return [self.class finderBestViewController:svc.viewControllers.lastObject];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *svc = (UINavigationController *)viewController;
        if (svc.viewControllers.count > 0) {
            return [self.class finderBestViewController:svc.topViewController];
        } else {
            return viewController;
        }
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *svc = (UITabBarController *)viewController;
        if (svc.viewControllers.count > 0) {
            return [self.class finderBestViewController:svc.selectedViewController];
        } else {
            return viewController;
        }
    } else {
        return viewController;
    }
}

+ (UIViewController *)rootCurrentViewController
{
    UIViewController *rootCurrentViewController = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0) {
        UIView *frontView = [viewsArray objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            rootCurrentViewController = nextResponder;
        } else {
            rootCurrentViewController = window.rootViewController;
        }
    }
    return rootCurrentViewController;
}

@end
