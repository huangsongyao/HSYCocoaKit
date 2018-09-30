//
//  HSYCustomRefreshView.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//  如果需要定制下拉的效果，请继承本类，并重写“- initWithRefreshDown:”入口方法、“- hsy_updatePullDownTriggerForPercent:”下拉偏移方法、“- hsy_updatePullUpTriggerForPercent:”上拉偏移方法，其中，“- hsy_updatePullDownTriggerForPercent:”下拉偏移方法、“- hsy_updatePullUpTriggerForPercent:”上拉偏移方法主要用于子类中获取到UIScrollView的滚动比例，通过滚动比例动态定制[0, 1]闭区间取值的交互动画效果

#import <UIKit/UIKit.h>
#import "UIScrollView+SVPullToRefresh.h"

@interface HSYCustomRefreshView : UIView

//YES表示使用根据下拉位移映射至[0, 1]的动态过度旋转，NO表示使用根据过度点做正向和反向的旋转动画过度，默认为NO
@property (nonatomic, assign) BOOL hsy_pullDownRotation;

/**
 入口方法预留的入参，YES表示下拉视图，NO表示上拉视图

 @param down 是否为下拉视图
 @return self
 */
- (instancetype)initWithRefreshDown:(BOOL)down;

/**
 *  更新下拉过程中的偏移量
 *
 *  @param percent 偏移量的百分比，取值为：[0, 1] 闭区间
 */
- (void)hsy_updatePullDownTriggerForPercent:(CGFloat)percent;

/**
 更新上拉过程中的偏移量，0位初始位置，1为上拉至最底部的位置

 @param percent 偏移量的百分比，取值为：[0, 1] 闭区间
 */
- (void)hsy_updatePullUpTriggerForPercent:(CGFloat)percent;

/**
 *  更新背景的颜色，并且该方案实现方向为，让下拉的视图不管下拉多少，本景色均显示为color
 *
 *  @param color 颜色
 */
- (void)hsy_updateLongTopBackgroundColor:(UIColor *)color;

/**
 设置下拉背景图

 @param image 下拉背景图
 */
- (void)hsy_updateLongTopBackgroundImage:(UIImage *)image;

/**
 开始刷新
 */
- (void)hsy_start;

/**
 停止刷新
 */
- (void)hsy_stop;

/**
 加载中会调用本方法

 @param isPullDown YES表示下拉，NO表示上拉
 */
- (void)hsy_loadingRefresh:(BOOL)isPullDown;

/**
 显示无更多数据时的上拉ui
 */
- (void)hsy_notMore;

/**
 重置可以加载更多数据的上拉ui
 */
- (void)hsy_hasMore;

#pragma mark - Load

/**
 返回一个默认的即将下拉的title内容，允许子类可以重写本方法返回一个定制的title

 @return will title
 */
+ (NSString *)hsy_refreshWillDownTitle;

/**
 返回一个默认的下拉刷新中的title内容，允许子类可以重写本方法返回一个定制的下拉刷新中的title

 @return loading title
 */
+ (NSString *)hsy_refreshDowningTitle;

/**
 返回一个默认的下拉松开后的title内容，允许子类可以重写本方法返回一个定制的下拉松开后的title

 @return downed title
 */
+ (NSString *)hsy_refreshDidDownedTitle;

/**
 返回一个默认的即将上拉的title内容，允许子类可以重写本方法返回一个定制的title

 @return will title
 */
+ (NSString *)hsy_refreshWillUpTitle;

/**
 返回一个默认的上拉刷新中的title内容，允许子类可以重写本方法返回一个定制的上拉刷新中的title

 @return loading title
 */
+ (NSString *)hsy_refreshUpingTitle;

/**
 返回一个默认的上拉松开后的title内容，允许子类可以重写本方法返回一个定制的上拉松开后的title

 @return downed title
 */
+ (NSString *)hsy_refreshDidUpedCompleted;

/**
 返回一个默认的箭头图标左对齐的偏移量，允许子类重写本方法返回一个定制的偏移量

 @return allow offset left
 */
+ (CGFloat)hsy_refreshAllowOffsetLeft;

/**
 返回一个上拉或者下拉的title的文字颜色，允许子类重写本方法返回一个定制的文字颜色

 @return title的文字颜色
 */
+ (UIColor *)hsy_titleColor;

/**
 返回一个上拉或者下拉的title的字号，允许子类重写本方法返回一个定制的字号

 @return title的字号
 */
+ (UIFont *)hsy_titleFont;

/**
 返回一个上拉或者下拉的箭头图标，允许子类重写本方法返回一个定制的箭头图标

 @return 上拉或者下拉的箭头图标
 */
- (UIImage *)hsy_allowImage;

/**
 返回一个上拉无更多数据图标，允许子类重写本方法返回一个定制的无更多数据图标

 @return 上拉无更多数据图标
 */
+ (UIImage *)hsy_completedImage;

/**
 返回一个默认的下拉偏转角度，允许子类重写本方法返回一个定制的下拉偏转角度

 @return 下拉偏转角度
 */
+ (CGFloat)hsy_triggerPercent;

@end

