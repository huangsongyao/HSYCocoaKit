//
// UIScrollView+SVInfiniteScrolling.m
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
//

#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+SVInfiniteScrolling.h"
#import "UIView+Frame.h"
#import "HSYCustomRefreshView.h"

static CGFloat const SVInfiniteScrollingViewHeight = 60;

@interface SVInfiniteScrollingView ()

@property (nonatomic, copy) void (^infiniteScrollingHandler)(void);

@property (nonatomic, readwrite) SVInfiniteScrollingState state;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, readwrite) CGFloat originalBottomInset;
@property (nonatomic, assign) BOOL wasTriggeredByUser;
@property (nonatomic, assign) BOOL isObserving;

- (void)resetScrollViewContentInset;
- (void)setScrollViewContentInsetForInfiniteScrolling;
- (void)setScrollViewContentInset:(UIEdgeInsets)insets;

@end

#pragma mark - UIScrollView (SVInfiniteScrollingView)
#import <objc/runtime.h>

static char UIScrollViewInfiniteScrollingView;
UIEdgeInsets scrollViewOriginalContentInsets;

@implementation UIScrollView (SVInfiniteScrolling)

@dynamic infiniteScrollingView;

- (void)addInfiniteScrollingWithLoadingView:(HSYCustomRefreshView *)loadingView subscribeActionHandler:(void (^)(void))actionHandler
{
    if(!self.infiniteScrollingView) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        SVInfiniteScrollingView *view = [[SVInfiniteScrollingView alloc] initWithLoadingView:loadingView frame:CGRectMake(0, self.contentSize.height, width, SVInfiniteScrollingViewHeight)];
        view.infiniteScrollingHandler = actionHandler;
        view.scrollView = self;
        [self addSubview:view];
        
        view.originalBottomInset = self.contentInset.bottom;
        self.infiniteScrollingView = view;
        self.showsInfiniteScrolling = YES;
    }
}

- (void)triggerInfiniteScrolling
{
    self.infiniteScrollingView.state = SVInfiniteScrollingStateTriggered;
    [self.infiniteScrollingView startAnimating];
}

- (void)setInfiniteScrollingView:(SVInfiniteScrollingView *)infiniteScrollingView
{
    [self willChangeValueForKey:@"UIScrollViewInfiniteScrollingView"];
    objc_setAssociatedObject(self, &UIScrollViewInfiniteScrollingView,
                             infiniteScrollingView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"UIScrollViewInfiniteScrollingView"];
}

- (SVInfiniteScrollingView *)infiniteScrollingView
{
    return objc_getAssociatedObject(self, &UIScrollViewInfiniteScrollingView);
}

- (void)setShowsInfiniteScrolling:(BOOL)showsInfiniteScrolling
{
    self.infiniteScrollingView.hidden = !showsInfiniteScrolling;
    
    if(!showsInfiniteScrolling) {
      if (self.infiniteScrollingView.isObserving) {
          [self removeObserver:self.infiniteScrollingView forKeyPath:@"contentOffset"];
          [self removeObserver:self.infiniteScrollingView forKeyPath:@"contentSize"];
          [self.infiniteScrollingView resetScrollViewContentInset];
          self.infiniteScrollingView.isObserving = NO;
        
          //后来添加的，当不再显示上拉时，把上拉的view高度重置为0，这样界面上就不会在底部很奇怪的空出一块东西出来
          self.infiniteScrollingView.height = 0;
      }
    } else {
      if (!self.infiniteScrollingView.isObserving) {
          [self addObserver:self.infiniteScrollingView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
          [self addObserver:self.infiniteScrollingView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
          [self.infiniteScrollingView setScrollViewContentInsetForInfiniteScrolling];
          self.infiniteScrollingView.isObserving = YES;
          
          [self.infiniteScrollingView setNeedsLayout];
          self.infiniteScrollingView.frame = CGRectMake(0, self.contentSize.height, self.infiniteScrollingView.bounds.size.width, SVInfiniteScrollingViewHeight);
      }
    }
}

- (BOOL)showsInfiniteScrolling
{
    return !self.infiniteScrollingView.hidden;
}

- (void)setShowsNoMoreDataView:(BOOL)showsNoMoreDataView
{
    self.infiniteScrollingView.hasMoreData = !showsNoMoreDataView;
    if (showsNoMoreDataView) {
        self.infiniteScrollingView.hidden = NO;
        [self.infiniteScrollingView setScrollViewContentInsetForInfiniteScrolling];
        [self.infiniteScrollingView setNeedsLayout];
        self.infiniteScrollingView.frame = CGRectMake(0, self.contentSize.height, self.infiniteScrollingView.bounds.size.width, SVInfiniteScrollingViewHeight);
    }
}

- (BOOL)showsNoMoreDataView
{
    return !self.infiniteScrollingView.hasMoreData;
}

@end

#pragma mark - SVInfiniteScrollingView

@implementation SVInfiniteScrollingView

- (instancetype)initWithLoadingView:(HSYCustomRefreshView *)loadingView frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.state = SVInfiniteScrollingStateStopped;
        self.enabled = YES;
        
        _loadingView = loadingView;
        _loadingView.frame = self.bounds;
        [self addSubview:self.loadingView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.superview && newSuperview == nil) {
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        if (scrollView.showsInfiniteScrolling) {
          if (self.isObserving) {
            [scrollView removeObserver:self forKeyPath:@"contentOffset"];
            [scrollView removeObserver:self forKeyPath:@"contentSize"];
            self.isObserving = NO;
          }
        }
    }
}

- (void)setHasMoreData:(BOOL)hasMoreData
{
    _hasMoreData = hasMoreData;
    self.loadingView.hidden = !hasMoreData;
}

#pragma mark - Scroll View

- (void)resetScrollViewContentInset
{
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = self.originalBottomInset;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForInfiniteScrolling
{
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.bottom = self.originalBottomInset + SVInfiniteScrollingViewHeight;
    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInset:(UIEdgeInsets)contentInset
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.scrollView.contentInset = contentInset;
                     }
                     completion:NULL];
}

#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewDidScroll:[[change valueForKey:NSKeyValueChangeNewKey] CGPointValue]];
    } else if([keyPath isEqualToString:@"contentSize"]) {
        [self layoutSubviews];
        self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.bounds.size.width, SVInfiniteScrollingViewHeight);
    }
}

- (void)scrollViewDidScroll:(CGPoint)contentOffset
{
    if(self.state != SVInfiniteScrollingStateLoading && self.enabled) {
        CGFloat scrollViewContentHeight = self.scrollView.contentSize.height;
        CGFloat scrollOffsetThreshold = scrollViewContentHeight-self.scrollView.bounds.size.height;
        
        if(!self.scrollView.isDragging && self.state == SVInfiniteScrollingStateTriggered) {
            if (self.scrollView.contentOffset.y > 0) {
                self.state = SVInfiniteScrollingStateLoading;
            }
           
        } else if(contentOffset.y > scrollOffsetThreshold && self.state == SVInfiniteScrollingStateStopped && self.scrollView.isDragging) {
            self.state = SVInfiniteScrollingStateTriggered;
        } else if(contentOffset.y < scrollOffsetThreshold  && self.state != SVInfiniteScrollingStateStopped) {
            self.state = SVInfiniteScrollingStateStopped;
        }
    }
}

#pragma mark - Set Refresh Status

- (void)triggerRefresh
{
    self.state = SVInfiniteScrollingStateTriggered;
    self.state = SVInfiniteScrollingStateLoading;
}

- (void)startAnimating
{
    self.state = SVInfiniteScrollingStateLoading;
}

- (void)stopAnimating
{
    self.state = SVInfiniteScrollingStateStopped;
}

- (void)setState:(SVInfiniteScrollingState)newState
{
    if(_state == newState) {
        return;
    }
    
    SVInfiniteScrollingState previousState = _state;
    _state = newState;

    switch (newState) {
        case SVInfiniteScrollingStateStopped: {
            [self.loadingView hsy_stop];
        }
            break;
                
        case SVInfiniteScrollingStateTriggered:
            break;
                
        case SVInfiniteScrollingStateLoading: {
            if (self.scrollView.contentOffset.y > 0) {
                [self.loadingView hsy_start];
            }
        }
            break;
    }
    
    if(previousState == SVInfiniteScrollingStateTriggered && newState == SVInfiniteScrollingStateLoading && self.infiniteScrollingHandler && self.enabled) {
        self.infiniteScrollingHandler();
    }
}

@end
