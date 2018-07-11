//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <UIKit/UIKit.h>
#import "UIViewController+NavigationItem.h"

@interface HSYCustomNavigationBar : UINavigationBar

//创建一个导航栏专用的item项，使用规则和正常使用UIViewController的navigationItem相同
@property (nonatomic, strong, readonly) UINavigationItem *customNavigationItem;

/**
 初始化，object请传入NSString或UIView,如果传入nil，默认不显示
 
 @param object  NSString或UIView，前者表示title，后者表示titleView
 @return HSYCustomNavigationBar
 */
- (instancetype)initWithObject:(id)object;

#pragma mark - BackgroundImage

/**
 设置bar的背景图片，如果backgroundImage为nil，则默认为白色
 
 @param backgroundImage 背景图片
 */
- (void)setCustomNavigationBarBackgroundImage:(UIImage *)backgroundImage;

#pragma mark - Line

/**
 清除底部横线
 */
- (void)hsy_clearNavigationBarBottomLine;

/**
 设置底部横线的色值，高度默认1.0dx
 
 @param color 横线的颜色
 */
- (void)hsy_customBarBottomLineOfColor:(UIColor *)color;

#pragma mark - Back Button

/**
 创建导航栏的返回按钮，图片模式，允许设置图片，默认内容左偏移DEFAULT_BUTTOM_EDGE_INSETS_LEFT

 @param normal normal图片名称
 @param press press图片名称
 @param next 点击回调事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)hsy_backButtonItemForImage:(NSString *)normal
                                      highImage:(NSString *)press
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建导航栏的返回按钮，文字模式，允许设置文字，默认内容左偏移DEFAULT_BUTTOM_EDGE_INSETS_LEFT
 
 @param title 文字内容
 @param next 点击回调事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)hsy_backButtonItemForTitle:(NSString *)title
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建导航栏的返回按钮，文字模式，允许设置文字

 @param title 文字内容
 @param left 内容偏移，负数表示左偏移，正数表示又偏移
 @param next 点击回调事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)hsy_backButtonItemForTitle:(NSString *)title
                                           left:(CGFloat)left
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建导航栏的返回按钮，图片模式，允许设置图片

 @param normal normal图片名称
 @param press press图片名称
 @param left 内容偏移，负数表示左偏移，正数表示又偏移
 @param next 点击回调事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)hsy_backButtonItemForImage:(NSString *)normal
                                      highImage:(NSString *)press
                                           left:(CGFloat)left
                                  subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建导航栏的返回按钮，图片+文字模式，允许设置图片和文字，默认内容左偏移DEFAULT_BUTTOM_EDGE_INSETS_LEFT

 @param normal normal图片名称
 @param press press图片名称
 @param title 文字内容
 @param next 点击回调事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)hsy_defalutBackButtonItemForImage:(NSString *)normal
                                             highImage:(NSString *)press
                                                 title:(NSString *)title
                                         subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建导航栏的返回按钮，图片+文字模式，允许设置图片和文字

 @param normal normal图片名称
 @param press press图片名称
 @param title 文字内容
 @param left 内容偏移，负数表示左偏移，正数表示又偏移
 @param next 点击回调事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)hsy_defalutBackButtonItemForImage:(NSString *)normal
                                             highImage:(NSString *)press
                                                 title:(NSString *)title
                                                  left:(CGFloat)left
                                         subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

@end

NS_CLASS_AVAILABLE_IOS(11_0) @interface HSYCustomNavigationContentViewBar : UIView

@property (nonatomic, strong, readonly) HSYCustomNavigationBar *navigationBar;

/**
 初始化，object请传入NSString或UIView,如果传入nil，默认不显示
 
 @param object  NSString或UIView，前者表示title，后者表示titleView
 @return HSYCustomNavigationContentViewBar
 */
- (instancetype)initWithObject:(id)object;

/**
 设置背景图片
 
 @param backgroundImage 背景图片
 */
- (void)setCustomNavigationContentBarBackgroundImage:(UIImage *)backgroundImage;

@end
