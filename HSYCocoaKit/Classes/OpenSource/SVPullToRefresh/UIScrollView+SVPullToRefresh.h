//
// UIScrollView+SVPullToRefresh.h
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
// 在SVPullToRefresh开源库的基础上，重新定义下拉更新

#import <UIKit/UIKit.h>
#import <AvailabilityMacros.h>

static CGFloat const SVPullToRefreshViewHeight = 77.0f;

@class SVPullToRefreshView;
@class HSYCustomRefreshView;

@interface UIScrollView (SVPullToRefresh)

/**
 添加下拉刷新

 @param loadingView 刷新的头部视图
 @param actionHandler 回调触发方法
 */
- (void)addPullToRefreshWithLoadingView:(HSYCustomRefreshView *)loadingView subscribeActionHandler:(void (^)(void))actionHandler;
- (void)triggerPullToRefresh;
- (void)setLoadingBackgroundColor:(UIColor *)backgroundColor;

@property (nonatomic, strong, readonly) SVPullToRefreshView *pullToRefreshView;
@property (nonatomic, assign) BOOL showsPullToRefresh;

@end

typedef NS_ENUM(NSUInteger, SVPullToRefreshState) {
    
    SVPullToRefreshStateStopped = 0,
    SVPullToRefreshStateTriggered,
    SVPullToRefreshStateLoading,
    SVPullToRefreshStateAll = 10
    
};

@interface SVPullToRefreshView : UIView

@property (nonatomic, strong, readonly) HSYCustomRefreshView *loadingView;
@property (nonatomic, readonly) SVPullToRefreshState state;

- (instancetype)initWithLoadingView:(HSYCustomRefreshView *)loadingView frame:(CGRect)frame;
- (void)startAnimating;
- (void)stopAnimating;

@end
