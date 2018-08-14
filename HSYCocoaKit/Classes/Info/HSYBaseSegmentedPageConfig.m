//
//  HSYBaseSegmentedPageConfig.m
//  Pods
//
//  Created by huangsongyao on 2018/4/25.
//
//

#import "HSYBaseSegmentedPageConfig.h"
#import "HSYBaseViewController.h"

@implementation HSYBaseSegmentedPageConfig

+ (instancetype)initWithViewControllerClassName:(NSString *)className viewControllerTitle:(NSString *)title paramters:(NSDictionary<NSString *, NSString *> *)paramters
{
    return [[self alloc] initWithClassName:className title:title paramters:paramters];
}

- (instancetype)initWithClassName:(NSString *)className title:(NSString *)title paramters:(NSDictionary<NSString *, NSString *> *)paramters
{
    return [self initWithIsHSYBaseModel:NO className:className title:title paramters:paramters];
}

- (instancetype)initWithBaseViewModelClassName:(NSString *)className title:(NSString *)title paramters:(NSDictionary<NSString *,NSString *> *)paramters
{
    return [self initWithIsHSYBaseModel:YES className:className title:title paramters:paramters];
}

- (instancetype)initWithIsHSYBaseModel:(BOOL)isModel className:(NSString *)className title:(NSString *)title paramters:(NSDictionary<NSString *, NSString *> *)paramters
{
    if (self = [super init]) {
        _hsy_viewController = [[NSClassFromString(className) alloc] init];
        _hsy_title = title;
        self.showNavigationBar = NO;
        for (NSString *key in paramters.allKeys) {
            if (isModel) {
                HSYBaseViewController *baseViewController = (HSYBaseViewController *)self.hsy_viewController;
                if ([baseViewController.hsy_viewModel respondsToSelector:NSSelectorFromString(key)]) {
                    [baseViewController.hsy_viewModel setValue:paramters[key] forKey:key];
                }
            } else {
                if ([self.hsy_viewController respondsToSelector:NSSelectorFromString(key)]) {
                    [self.hsy_viewController setValue:paramters[key] forKey:key];
                }
            }
        }
    }
    return self;
}

- (void)setShowNavigationBar:(BOOL)showNavigationBar
{
    _showNavigationBar = showNavigationBar;
    if (self.showNavigationBar) {
        if ([self.hsy_viewController isKindOfClass:[HSYBaseViewController class]]) {
            [(HSYBaseViewController *)self.hsy_viewController hsy_addCustomNavigationBar];
        }
    } else {
        if ([self.hsy_viewController isKindOfClass:[HSYBaseViewController class]]) {
            [(HSYBaseViewController *)self.hsy_viewController hiddenCustomNavigationBar];
        }
    }
}

@end

@implementation HSYBaseTabBarControllerConfig

+ (instancetype)initWithViewControllerClassName:(NSString *)className
                            viewControllerTitle:(NSString *)title
                                      paramters:(NSDictionary<NSString *,NSString *> *)paramters
                             titleColorParamter:(NSDictionary<UIColor *,UIColor *> *)titleColorParamter
                                  imageParamter:(NSDictionary<NSString *,NSString *> *)imageParamter
                                   fontParamter:(NSDictionary<UIFont *,UIFont *> *)fontParamter
{
    HSYBaseTabBarControllerConfig *config = [HSYBaseTabBarControllerConfig initWithViewControllerClassName:className viewControllerTitle:title paramters:paramters];
    config.titleColorParamter = titleColorParamter;
    config.imageParamter = imageParamter;
    config.fontParamter = fontParamter;
    
    return config;
}

@end

