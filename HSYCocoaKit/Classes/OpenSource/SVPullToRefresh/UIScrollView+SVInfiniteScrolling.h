//
// UIScrollView+SVInfiniteScrolling.h
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
// 在SVPullToRefresh开源库的基础上，重新定义上拉加载

#import <UIKit/UIKit.h>

@class SVInfiniteScrollingView;
@class HSYCustomRefreshView;

@interface UIScrollView (SVInfiniteScrolling)

/**
 添加上拉加载更多
 
 @param loadingView 刷新的尾部视图
 @param actionHandler 回调触发方法
 */
- (void)addInfiniteScrollingWithLoadingView:(HSYCustomRefreshView *)loadingView subscribeActionHandler:(void (^)(void))actionHandler;
- (void)triggerInfiniteScrolling;

@property (nonatomic, strong, readonly) SVInfiniteScrollingView *infiniteScrollingView;
@property (nonatomic, assign) BOOL showsInfiniteScrolling;
@property (nonatomic, assign) BOOL showsNoMoreDataView;

@end

enum {
	SVInfiniteScrollingStateStopped = 0,
    SVInfiniteScrollingStateTriggered,
    SVInfiniteScrollingStateLoading,
    SVInfiniteScrollingStateAll = 10
};

typedef NSUInteger SVInfiniteScrollingState;

@interface SVInfiniteScrollingView : UIView

@property (nonatomic, readonly) SVInfiniteScrollingState state;
@property (nonatomic, readwrite) BOOL enabled;
@property (nonatomic, assign) BOOL hasMoreData;

@property (nonatomic, strong, readonly) HSYCustomRefreshView *loadingView;
@property (nonatomic, strong) UIView *noMoreDataView;

- (instancetype)initWithLoadingView:(HSYCustomRefreshView *)loadingView frame:(CGRect)frame;
- (void)startAnimating;
- (void)stopAnimating;

@end
