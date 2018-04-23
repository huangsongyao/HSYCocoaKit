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

- (instancetype)initWithRefreshDown:(BOOL)down;

/**
 *  更新下拉过程中的偏移量
 *
 *  @param percent 偏移量的百分比，取值为：[0, 1]
 *  @param state   当前类型枚举
 */
- (void)hsy_updateTriggerForPercent:(CGFloat)percent refreshState:(SVPullToRefreshState)state;

/**
 *  更新背景的颜色，并且该方案实现方向为，让下拉的视图不管下拉多少，本景色均显示为color
 *
 *  @param color 颜色
 */
- (void)hsy_updateLongTopBackgroundColor:(UIColor *)color;

/**
 开始上拉
 */
- (void)hsy_startPullUp;

/**
 开始下拉
 */
- (void)hsy_startPullDown;

/**
 停止上拉
 */
- (void)hsy_stopPullUp;

/**
 停止下拉
 */
- (void)hsy_stopPullDown;

@end

