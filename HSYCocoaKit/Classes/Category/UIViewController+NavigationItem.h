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

typedef NS_ENUM(NSUInteger, kHSYCustomBarButtonItemTag) {
    
    kHSYCustomBarButtonItemTagBack = 0,             //返回按钮
};


@interface UIViewController (NavigationItem)

/**
 创建导航栏按钮集合--------@[UIBarButtonItem]，图片模式

 @param images 导航栏按钮的背景图片集合
 @param left 正数表示左偏移量，负数表示右偏移量
 @param next 点击回调事件，kHSYCustomBarButtonItemTag枚举表示回调的类型
 @return 导航按钮
 */
+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsImages:(NSArray<NSDictionary *> *)images edgeInsetsLeft:(CGFloat)left subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next;

/**
 创建导航栏按钮集合--------@[UIBarButtonItem]，文字模式

 @param titles 导航栏按钮的title集合
 @param left 正数表示左偏移量，负数表示右偏移量
 @param next 点击回调事件，kHSYCustomBarButtonItemTag枚举表示回调的类型
 @return 导航按钮
 */
+ (NSArray <UIBarButtonItem *>*)hsy_barButtonItemsTitles:(NSArray<NSDictionary *> *)titles edgeInsetsLeft:(CGFloat)left subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next;

@end
