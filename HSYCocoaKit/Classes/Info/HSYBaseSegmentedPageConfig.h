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

@property (nonatomic, strong) UIViewController *hsy_viewController; //子控制器
@property (nonatomic, copy) NSString *hsy_title;                    //子控制器的title
@property (nonatomic, assign) BOOL showNavigationBar;               //默认为NO，NO表示不显示头部的导航栏
@property (nonatomic, copy) NSString *hsy_functionCode;             //预留的功能码字段
@property (nonatomic, strong) id object;                            //预留的强引用对象指针

/**
 根据paramters入参使用kvc方式，将paramters中的allValue设置到UIViewController中

 @param className UIViewController的类名
 @param paramters UIViewController的属性集合，格式为：@{@"属性名称" : @"属性名称对应的值", ...}
 @return HSYBaseSegmentedPageConfig
 */
+ (instancetype)initWithViewControllerClassName:(NSString *)className viewControllerTitle:(NSString *)title paramters:(NSDictionary<NSString *, NSString *> *)paramters;

@end

@interface HSYBaseTabBarControllerConfig : HSYBaseSegmentedPageConfig

//格式为：@{normal的color : selected的color}
@property (nonatomic, strong) NSDictionary<UIColor *, UIColor *> *titleColorParamter;
//格式为：@{@"normal的image" : @"selected的image"}
@property (nonatomic, strong) NSDictionary<NSString *, NSString *> *imageParamter;
//格式为：@{@"normal的font" : @"selected的font"}
@property (nonatomic, strong) NSDictionary<UIFont *, UIFont *> *fontParamter;

/**
 根据入参提供的tabBarConfig初始化接口

 @param className UIViewController的类名
 @param title UIViewController的title
 @param paramters UIViewController的属性集合，格式为：@{@"属性名称" : @"属性名称对应的值", ...}
 @param titleColorParamter tabBarItem中的字体颜色，格式为：@{@"未选中的颜色" : @"选中后的颜色"}
 @param imageParamter tabBarItem中的图片，格式为：@{@"未选中的图片名称" : @"选中的图片名称"}
 @param fontParamter tabBarItem中的字体，格式为：@{@"未选中的字体字号" : @"选中的字体字号"}
 @return HSYBaseTabBarControllerConfig
 */
+ (instancetype)initWithViewControllerClassName:(NSString *)className
                            viewControllerTitle:(NSString *)title
                                      paramters:(NSDictionary<NSString *, NSString *> *)paramters
                             titleColorParamter:(NSDictionary<UIColor *, UIColor *> *)titleColorParamter
                                  imageParamter:(NSDictionary<NSString *, NSString *> *)imageParamter
                                   fontParamter:(NSDictionary<UIFont *, UIFont *> *)fontParamter;

@end
