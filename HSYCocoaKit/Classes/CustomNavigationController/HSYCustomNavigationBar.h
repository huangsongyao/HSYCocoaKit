//
//  HSYCustomNavigationBar.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kHSYCustomBarButtonItemTag) {
    
    kHSYCustomBarButtonItemTagBack = 0,             //返回的tag
    
};


@interface HSYCustomNavigationBar : UINavigationBar

@property (nonatomic, strong, readonly) UINavigationItem *customNavigationItem;                 //创建一个导航栏专用的item项，使用规则和正常使用UIViewController的navigationItem相同

/**
 清除底部横线
 */
- (void)clearNavigationBarBottomLine;

/**
 设置底部横线的色值，高度默认1.0dx
 
 @param color 横线的颜色
 */
- (void)customBarBottomLineOfColor:(UIColor *)color;

/**
 创建导航栏的返回按钮，返回的箭头图片默认为@"nav_icon_back"
 
 @param next 点击回调事件
 @return UIBarButtonItem
 */
+ (UIBarButtonItem *)backButtonItem:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next;
+ (UIBarButtonItem *)backButtonItemForImage:(NSString *)name subscribeNext:(void(^)(UIButton *button, kHSYCustomBarButtonItemTag tag))next;

/**
 从当前私有库的bundle中获取资源图片

 @param imageName 图片名称
 @return UIImage
 */
+ (UIImage *)imageForBundle:(NSString *)imageName;

@end
