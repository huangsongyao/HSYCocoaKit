//
// UIScrollView+SVPullToRefresh.m
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SVPullToRefresh
//

#import <QuartzCore/QuartzCore.h>
#import "UIScrollView+SVPullToRefresh.h"
#import "UIView+Frame.h"
#import "HSYCustomRefreshView.h"
#import "PublicMacroFile.h"

//fequal() and fequalzro() from http://stackoverflow.com/a/1614761/184130
#define fequal(a,b) (fabs((a) - (b)) < FLT_EPSILON)
#define fequalzero(a) (fabs(a) < FLT_EPSILON)

@interface SVPullToRefreshView ()

@property (nonatomic, copy) void (^pullToRefreshActionHandler)(void);

@property (nonatomic, readwrite) SVPullToRefreshState state;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, readwrite) CGFloat originalTopInset;
@property (nonatomic, readwrite) CGFloat originalBottomInset;
@property (nonatomic, assign) BOOL wasTriggeredByUser;
@property (nonatomic, assign) BOOL showsPullToRefresh;
@property (nonatomic, assign) BOOL isObserving;

- (void)resetScrollViewContentInset;
- (void)setScrollViewContentInsetForLoading;
- (void)setScrollViewContentInset:(UIEdgeInsets)insets;

@end

#pragma mark - UIScrollView (SVPullToRefresh)
#import <objc/runtime.h>

static char UIScrollViewPullToRefreshView;

@implementation UIScrollView (SVPullToRefresh)

@dynamic pullToRefreshView;
@dynamic showsPullToRefresh;

- (void)addPullToRefreshWithLoadingView:(HSYCustomRefreshView *)loadingView subscribeActionHandler:(void (^)(void))actionHandler
{
    if(!self.pullToRefreshView) {
        CGFloat yOrigin = -SVPullToRefreshViewHeight;
        
        SVPullToRefreshView *view = [[SVPullToRefreshView alloc] initWithLoadingView:loadingView frame:CGRectMake(0, yOrigin, IPHONE_WIDTH, SVPullToRefreshViewHeight)];
        view.pullToRefreshActionHandler = actionHandler;
        view.scrollView = self;
        [self addSubview:view];
        
        view.originalTopInset = self.contentInset.top;
        view.originalBottomInset = self.contentInset.bottom;
        self.pullToRefreshView = view;
        self.showsPullToRefresh = YES;
    }
}

- (void)triggerPullToRefresh
{
    self.pullToRefreshView.state = SVPullToRefreshStateTriggered;
    [self.pullToRefreshView startAnimating];
}

- (void)setPullToRefreshView:(SVPullToRefreshView *)pullToRefreshView
{
    [self willChangeValueForKey:@"SVPullToRefreshView"];
    objc_setAssociatedObject(self, &UIScrollViewPullToRefreshView,
                             pullToRefreshView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"SVPullToRefreshView"];
}

- (SVPullToRefreshView *)pullToRefreshView
{
    return objc_getAssociatedObject(self, &UIScrollViewPullToRefreshView);
}

- (void)setShowsPullToRefresh:(BOOL)showsPullToRefresh
{
    self.pullToRefreshView.hidden = !showsPullToRefresh;
    
    if(showsPullToRefresh) {
        if (!self.pullToRefreshView.isObserving) {
            [self addObserver:self.pullToRefreshView forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.pullToRefreshView forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self.pullToRefreshView forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
            self.pullToRefreshView.isObserving = YES;
            
            CGFloat yOrigin = -SVPullToRefreshViewHeight;
            self.pullToRefreshView.frame = CGRectMake(0, yOrigin, self.bounds.size.width, SVPullToRefreshViewHeight);
        }
    }
    else {
        if (self.pullToRefreshView.isObserving) {
            [self removeObserver:self.pullToRefreshView forKeyPath:@"contentOffset"];
            [self removeObserver:self.pullToRefreshView forKeyPath:@"contentSize"];
            [self removeObserver:self.pullToRefreshView forKeyPath:@"frame"];
            [self.pullToRefreshView resetScrollViewContentInset];
            self.pullToRefreshView.isObserving = NO;
        }
    }
}

- (BOOL)showsPullToRefresh
{
    return !self.pullToRefreshView.hidden;
}

- (void)setLoadingBackgroundColor:(UIColor *)backgroundColor
{
    [self.pullToRefreshView.loadingView hsy_updateLongTopBackgroundColor:backgroundColor];
}

@end

#pragma mark - SVPullToRefresh

@implementation SVPullToRefreshView

- (instancetype)initWithLoadingView:(HSYCustomRefreshView *)loadingView frame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.state = SVPullToRefreshStateStopped;
        self.wasTriggeredByUser = YES;
        
        _loadingView = loadingView;
        _loadingView.frame = self.bounds;
        [self addSubview:self.loadingView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.superview && newSuperview == nil) {
        //use self.superview, not self.scrollView. Why self.scrollView == nil here?
        UIScrollView *scrollView = (UIScrollView *)self.superview;
        if (scrollView.showsPullToRefresh) {
            if (self.isObserving) {
                //If enter this branch, it is the moment just before "SVPullToRefreshView's dealloc", so remove observer here
                [scrollView removeObserver:self forKeyPath:@"contentOffset"];
                [scrollView removeObserver:self forKeyPath:@"contentSize"];
                [scrollView removeObserver:self forKeyPath:@"frame"];
                self.isObserving = NO;
            }
        }
    }
}


#pragma mark - Scroll View

- (void)resetScrollViewContentInset
{
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = self.originalTopInset;

    [self setScrollViewContentInset:currentInsets];
}

- (void)setScrollViewContentInsetForLoading
{
    CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0);
    UIEdgeInsets currentInsets = self.scrollView.contentInset;
    currentInsets.top = MIN(offset, self.originalTopInset + self.bounds.size.height);
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
        CGFloat yOrigin = -SVPullToRefreshViewHeight;
        self.frame = CGRectMake(0, yOrigin, self.bounds.size.width, SVPullToRefreshViewHeight);
    } else if([keyPath isEqualToString:@"frame"]) {
        [self layoutSubviews];
    }
}

- (void)scrollViewDidScroll:(CGPoint)contentOffset
{
    if(self.state != SVPullToRefreshStateLoading) {
        CGFloat scrollOffsetThreshold = self.frame.origin.y - self.originalTopInset;
        if(self.state == SVPullToRefreshStateTriggered) {
            if (!self.scrollView.isDragging) {
                self.state = SVPullToRefreshStateLoading;
            } else if(self.scrollView.isDragging && contentOffset.y >= scrollOffsetThreshold && contentOffset.y < 0) {
                self.state = SVPullToRefreshStateStopped;
                CGFloat percent = contentOffset.y/scrollOffsetThreshold;
                [self.loadingView hsy_updatePullDownTriggerForPercent:percent];
            }
        } else if(self.state == SVPullToRefreshStateStopped) {
            if (contentOffset.y < scrollOffsetThreshold && self.scrollView.isDragging) {
                self.state = SVPullToRefreshStateTriggered;
                [self.loadingView hsy_updatePullDownTriggerForPercent:1];
            } else if(contentOffset.y >= scrollOffsetThreshold && contentOffset.y < 0) {
                CGFloat percent = contentOffset.y/scrollOffsetThreshold;
                [self.loadingView hsy_updatePullDownTriggerForPercent:percent];
            }
        } else if(self.state != SVPullToRefreshStateStopped ) {
            if (contentOffset.y >= scrollOffsetThreshold) {
                self.state = SVPullToRefreshStateStopped;
            }
        }
    } else {
        CGFloat offset = MAX(self.scrollView.contentOffset.y * -1, 0.0f);
        offset = MIN(offset, self.originalTopInset + self.bounds.size.height);
        UIEdgeInsets contentInset = self.scrollView.contentInset;
        self.scrollView.contentInset = UIEdgeInsetsMake(offset, contentInset.left, contentInset.bottom, contentInset.right);
    }
}

#pragma mark - Set Refresh Status

- (void)startAnimating
{
    if(fequalzero(self.scrollView.contentOffset.y)) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -self.frame.size.height) animated:YES];
        self.wasTriggeredByUser = NO;
        _state = SVPullToRefreshStateTriggered;
    } else {
        self.wasTriggeredByUser = YES;
    }
    self.state = SVPullToRefreshStateLoading;
}

- (void)stopAnimating
{
    self.state = SVPullToRefreshStateStopped;
    if(!self.wasTriggeredByUser) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x, -self.originalTopInset) animated:YES];
    }
}

- (void)setState:(SVPullToRefreshState)newState
{
    if(_state == newState) {
        return;
    }

    SVPullToRefreshState previousState = _state;
    _state = newState;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    switch (newState) {
        case SVPullToRefreshStateAll:
        case SVPullToRefreshStateStopped: {
            [self.loadingView hsy_stop];
            [self resetScrollViewContentInset];
        }
            break;
            
        case SVPullToRefreshStateTriggered:
            break;
            
        case SVPullToRefreshStateLoading: {
            [self.loadingView hsy_start];
            [self setScrollViewContentInsetForLoading];
            if(previousState == SVPullToRefreshStateTriggered && _pullToRefreshActionHandler) {
                _pullToRefreshActionHandler();
            }
        }
            break;
    }
}

@end

