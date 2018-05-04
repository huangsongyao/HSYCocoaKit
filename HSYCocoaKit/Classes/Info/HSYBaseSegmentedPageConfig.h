//
//  HSYBaseSegmentedPageConfig.h
//  Pods
//
//  Created by huangsongyao on 2018/4/25.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HSYBaseSegmentedPageConfig : NSObject

@property (nonatomic, strong) UIViewController *hsy_viewController;
@property (nonatomic, copy) NSString *hsy_title;
//默认为NO，NO表示不显示头部的导航栏
@property (nonatomic, assign) BOOL showNavigationBar;

/**
 根据paramters入参使用kvc方式，将paramters中的allValue设置到UIViewController中

 @param className UIViewController的类名
 @param paramters UIViewController的属性集合，格式为@{@"属性名称" : @"属性名称对应的值", ...}
 @return HSYBaseSegmentedPageConfig
 */
+ (instancetype)initWithViewControllerClassName:(NSString *)className viewControllerTitle:(NSString *)title paramters:(NSDictionary<NSString *, NSString *> *)paramters;

@end

@interface HSYBaseTabBarControllerConfig : HSYBaseSegmentedPageConfig

//格式为：@{normal的color : selected的color}
@property (nonatomic, strong) NSDictionary<UIColor *, UIColor *> *titleColorParamter;
//格式为：@{@"normal的image" : @"selected的image"}
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *imageParamter;

+ (instancetype)initWithViewControllerClassName:(NSString *)className
                            viewControllerTitle:(NSString *)title
                                      paramters:(NSDictionary<NSString *, NSString *> *)paramters
                             titleColorParamter:(NSDictionary<UIColor *, UIColor *> *)titleColorParamter
                                  imageParamter:(NSDictionary<NSString *, NSString *> *)imageParamter;

@end
