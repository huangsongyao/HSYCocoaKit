//
//  HSYBaseViewController+CustomNavigationItem.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYBaseViewController.h"

@interface HSYBaseViewController (CustomNavigationItem)

/**
 快速创建左部分的导航栏按钮----图片类型
 
 @param images 图片内容，格式为：@{@(导航栏按钮tag) : @"图片名称")}
 @param next 按钮点击事件
 */
- (void)hsy_leftItemsImages:(NSArray<NSDictionary *> *)images
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 快速创建右部分的导航栏按钮----图片类型
 
 @param images 图片内容，格式为@{@(导航栏按钮tag) : @"图片名称")}
 @param next 按钮点击事件
 */
- (void)hsy_rightItemsImages:(NSArray<NSDictionary *> *)images
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 快速创建左部分的导航栏按钮----文字类型，默认黑色字体颜色，15号字号
 
 @param titles title内容，格式为：@{@(导航栏按钮tag) : @"title内容"}
 @param next 按钮点击事件
 */
- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles
              subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 快速创建右部分的导航栏按钮----文字类型，默认黑色字体颜色，15号字号
 
 @param titles title内容，格式为：@{@(导航栏按钮tag) : @"title内容"}
 @param next 按钮点击事件
 */
- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles
               subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 快速创建左部分的导航栏按钮----文字类型

 @param titles title内容，格式为：@{@(导航栏按钮tag) : @"title内容"}
 @param titleColors 字体颜色
 @param titleFonts 字体字号
 @param next 按钮点击事件
 */
- (void)hsy_leftItemsTitles:(NSArray<NSDictionary *> *)titles titleColors:(NSArray<UIColor *> *)titleColors titleFonts:(NSArray<UIFont *> *)titleFonts subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 快速创建右部分的导航栏按钮----文字类型

 @param titles title内容，格式为：@{@(导航栏按钮tag) : @"title内容"}
 @param titleColors 字体颜色
 @param titleFonts 字体字号
 @param next 按钮点击事件
 */
- (void)hsy_rightItemsTitles:(NSArray<NSDictionary *> *)titles titleColors:(NSArray<UIColor *> *)titleColors titleFonts:(NSArray<UIFont *> *)titleFonts subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

@end
