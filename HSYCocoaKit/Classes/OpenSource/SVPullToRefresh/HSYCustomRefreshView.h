//
//  HSYCustomRefreshView.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//  如果需要定制下拉的效果，请继承本类，并重写“- initWithRefreshDown:”入口方法、“- hsy_updatePullDownTriggerForPercent:”下拉偏移方法、“- hsy_updatePullUpTriggerForPercent:”上拉偏移方法，其中，“- hsy_updatePullDownTriggerForPercent:”下拉偏移方法、“- hsy_updatePullUpTriggerForPercent:”上拉偏移方法主要用于子类中获取到UIScrollView的滚动比例，通过滚动比例动态定制[0, 1]闭区间取值的交互动画效果

#import <UIKit/UIKit.h>
#import "UIScrollView+SVPullToRefresh.h"

#define MAX_TRIGGER_PERCENT             1.0f
#define MID_TRIGGER_PERCENT             0.9f
#define MIN_TRIGGER_PERCENT             0.0f
#define MAX_TRIGGER_UP_PERCENT          1.01f

@interface HSYCustomRefreshView : UIView

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
 开始刷新
 */
- (void)hsy_start;

/**
 停止刷新
 */
- (void)hsy_stop;


@end

