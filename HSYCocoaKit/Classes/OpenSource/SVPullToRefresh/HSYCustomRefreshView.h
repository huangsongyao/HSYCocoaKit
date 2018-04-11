//
//  HSYCustomRefreshView.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <UIKit/UIKit.h>
#import "UIScrollView+SVPullToRefresh.h"

#define MAX_TRIGGER_PERCENT     1.0f
#define MID_TRIGGER_PERCENT     0.6f
#define MIN_TRIGGER_PERCENT     0.0f

@interface HSYCustomRefreshView : UIView

//容器视图，定制的视图请放于此处，默认会有一个容器视图的上下拉的UI
@property (nonatomic, strong, readonly) UIView *contentView;

/**
 *  更新下拉过程中的偏移量
 *
 *  @param percent 偏移量的百分比，取值为：[0, 1]
 *  @param state   当前类型枚举
 */
- (void)hsy_updateTriggerForPercent:(CGFloat)percent refreshState:(SVPullToRefreshState)state;

/**
 *  更新背景的颜色
 *
 *  @param color 颜色
 */
- (void)hsy_updateBackgroundColor:(UIColor *)color;

/**
 *  开始刷新
 */
- (void)hsy_start;

/**
 *  刷新结束
 */
- (void)hsy_stop;

@end

