//
//  HSYBaseSegmentedPageConfig.m
//  Pods
//
//  Created by huangsongyao on 2018/4/25.
//
//

#import "HSYBaseSegmentedPageConfig.h"

@implementation HSYBaseSegmentedPageConfig

+ (instancetype)initWithViewControllerClassName:(NSString *)className viewControllerTitle:(NSString *)title paramters:(NSDictionary<NSString *, NSString *> *)paramters
{
    return [[self alloc] initWithClassName:className title:title paramters:paramters];
}

- (instancetype)initWithClassName:(NSString *)className title:(NSString *)title paramters:(NSDictionary<NSString *, NSString *> *)paramters
{
    if (self = [super init]) {
        _hsy_viewController = [[NSClassFromString(className) alloc] init];
        _hsy_title = title;
        for (NSString *key in paramters.allKeys) {
            if ([self.hsy_viewController respondsToSelector:NSSelectorFromString(key)]) {
                [self.hsy_viewController setValue:paramters[key] forKey:key];
            }
        }
    }
    return self;
}

@end
