//
//  UIViewController+NavigationItem.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import <UIKit/UIKit.h>

#define DEFAULT_BUTTOM_SIZE                     40.0f
#define DEFAULT_BUTTOM_EDGE_INSETS_LEFT         10.0f

FOUNDATION_EXPORT NSInteger const kHSYCocoaKitDefaultCustomBarItemTag;  //默认返回按钮的tag

@interface UIViewController (NavigationItem)

/**
 创建导航栏按钮集合--------@[UIBarButtonItem]，图片模式

 @param images 导航栏按钮的背景图片集合，格式为:@[@{@(tag1) : @"图片1名称"}, @{@(tag2) : @"图片2名称"}, ...]
 @param left 正数表示左偏移量，负数表示右偏移量
 @param next 点击回调事件
 @return 导航按钮
 */
+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsImages:(NSArray<NSDictionary *> *)images
                                          edgeInsetsLeft:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建导航栏按钮集合--------@[UIBarButtonItem]，文字模式，title颜色为黑色，字体为15

 @param titles 导航栏按钮的title集合，格式为:@[@{@(tag1) : @"按钮1title"}, @{@(tag2) : @"按钮2title"}, ...]
 @param left 正数表示左偏移量，负数表示右偏移量
 @param next 点击回调事件
 @return 导航按钮
 */
+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsTitles:(NSArray<NSDictionary *> *)titles
                                          edgeInsetsLeft:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

/**
 创建导航栏按钮集合--------@[UIBarButtonItem]，文字模式

 @param titles 导航栏按钮的title集合，格式为:@[@{@(tag1) : @"按钮1title"}, @{@(tag2) : @"按钮2title"}, ...]
 @param titleColors 导航栏按钮字体颜色集合
 @param titleFonts 导航栏按钮字体字号集合
 @param left 正数表示左偏移量，负数表示右偏移量
 @param next 点击回调事件
 @return 导航按钮
 */
+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsTitles:(NSArray<NSDictionary *> *)titles
                                             titleColors:(NSArray<UIColor *> *)titleColors
                                              titleFonts:(NSArray<UIFont *> *)titleFonts
                                          edgeInsetsLeft:(CGFloat)left
                                           subscribeNext:(void(^)(UIButton *button, NSInteger tag))next;

@end
