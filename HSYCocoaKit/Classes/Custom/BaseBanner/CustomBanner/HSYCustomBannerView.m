//
//  HSYCustomBannerView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import "HSYCustomBannerView.h"
#import "HSYCustomBannerPageControl.h"
#import "UIView+Frame.h"
#import "UIScrollView+Page.h"
#import "NSObject+UIKit.h"

#define HSYCOCOAKIT_INFINITE_SCROLL_DEFAULT_OFFSET_COUNT        2
#define HSYCOCOAKIT_INFINITE_SCROLL_DEFAULT_SPACING             10.0f

@implementation HSYCustomBannerDataSourece

@end

//***************************************************************************************

@interface HSYCustomBannerView () <UIScrollViewDelegate, UIGestureRecognizerDelegate, HSYCustomBannerBaseCellDelegate>

@property (nonatomic, strong) UIScrollView *hsy_scrollView;
@property (nonatomic, strong) RACDisposable *hsy_disposable;
@property (nonatomic, strong) HSYCustomBannerPageControl *hsy_pageControl;
@property (nonatomic, strong) NSMutableArray *hsy_containerViews;

@end

@implementation HSYCustomBannerView

- (instancetype)initWithFrame:(CGRect)frame
                        pages:(NSArray<HSYCustomBannerDataSourece *> *)pages
                     delegate:(id<HSYCustomBannerViewDelegate>)delegate
                   dataSource:(id<HSYCustomBannerViewDataSource>)dataSource
{
    if (self = [super initWithFrame:frame]) {
        
        _hsy_delegate = delegate;
        _hsy_dataSource = dataSource;
        _hsy_pages = pages;
        _hsy_containerViews = [NSMutableArray arrayWithCapacity:pages.count];
        self.hsy_scrollView = [NSObject createScrollViewByParam:@{@(kHSYCocoaKitOfScrollViewPropretyTypeDelegate) : self, @(kHSYCocoaKitOfScrollViewPropretyTypePagingEnabled) : @(YES), @(kHSYCocoaKitOfScrollViewPropretyTypeBounces) : @(NO), @(kHSYCocoaKitOfScrollViewPropretyTypeHiddenScrollIndicator) : @(YES), @(kHSYCocoaKitOfScrollViewPropretyTypeContentSize) : [NSValue valueWithCGSize:CGSizeMake((self.width * (pages.count + HSYCOCOAKIT_INFINITE_SCROLL_DEFAULT_OFFSET_COUNT)), self.height)]}];
        [self addSubview:self.hsy_scrollView];
        
        self.hsy_scrollView.clipsToBounds = NO;
        self.hsy_scrollView.layer.masksToBounds = NO;
        self.hsy_scrollView.frame = self.bounds;
        [self loadData];
    }
    return self;
}

- (void)loadData
{
    [self.hsy_containerViews removeAllObjects];
    NSArray *subViews = [self.hsy_scrollView subviews];
    if (subViews.count > 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    CGFloat spacing = HSYCOCOAKIT_INFINITE_SCROLL_DEFAULT_SPACING;
    if (self.hsy_dataSource && [self.hsy_dataSource respondsToSelector:@selector(hsy_revisionBannerCellSpacing:)]) {
        spacing = [self.hsy_dataSource hsy_revisionBannerCellSpacing:self];
    }
    for (NSInteger i = 0; i < (self.hsy_pages.count + HSYCOCOAKIT_INFINITE_SCROLL_DEFAULT_OFFSET_COUNT); i ++) {
        if (self.hsy_dataSource && [self.hsy_dataSource respondsToSelector:@selector(hsy_revisionBannerView:cellForPageAtIndex:)]) {
            NSInteger index = (self.hsy_pages.count + (1 + i - 2)) % self.hsy_pages.count;
//            NSLog(@"index = %ld", index);
            HSYCustomBannerBaseCell *cell = [self.hsy_dataSource hsy_revisionBannerView:self cellForPageAtIndex:index];
            cell.hsy_delegate = self;
            cell.frame = CGRectMake(((i * self.width) + spacing), 0, (self.width - (spacing * 2)), self.height);
            [self.hsy_scrollView addSubview:cell];
            [self.hsy_containerViews addObject:cell];
        }
    }
    self.hsy_scrollView.scrollEnabled = (self.hsy_pages.count > 1);
    [self.hsy_scrollView setXPage:1];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollDirection:(BOOL)right
{
    UIView *removeObject = (right ? self.hsy_containerViews.firstObject : self.hsy_containerViews.lastObject);
    [self.hsy_containerViews removeObject:removeObject];
    [removeObject removeFromSuperview];

    CGFloat spacing = HSYCOCOAKIT_INFINITE_SCROLL_DEFAULT_SPACING;
    if (self.hsy_dataSource && [self.hsy_dataSource respondsToSelector:@selector(hsy_revisionBannerCellSpacing:)]) {
        spacing = [self.hsy_dataSource hsy_revisionBannerCellSpacing:self];
    }
    for (NSInteger i = 0; i < self.hsy_containerViews.count; i ++) {
        HSYCustomBannerBaseCell *cell = self.hsy_containerViews[i];
        cell.frame = CGRectMake((right ? ((i * self.width) + spacing) : ((i * self.width) + spacing + self.width)), 0, (self.width - (spacing * 2)), self.height);
    }
    
    if (self.hsy_dataSource && [self.hsy_dataSource respondsToSelector:@selector(hsy_revisionBannerView:cellForPageAtIndex:)]) {
        NSInteger index = ((self.hsy_currentPage + 1 + 2) % self.hsy_pages.count);
        if (!right) {
            index = ((self.hsy_pages.count + (self.hsy_currentPage - 1 - 2)) % self.hsy_pages.count);
        }
        NSLog(@"index = %ld", (long)index);
        HSYCustomBannerBaseCell *cell = [self.hsy_dataSource hsy_revisionBannerView:self cellForPageAtIndex:index];
        cell.hsy_delegate = self;
        CGFloat x = (right ? (self.hsy_pages.count + (HSYCOCOAKIT_INFINITE_SCROLL_DEFAULT_OFFSET_COUNT - 1)) * self.width : 0.0f);
        cell.frame = CGRectMake((x + spacing), 0, (self.width - (spacing * 2)), self.height);
        [self.hsy_scrollView addSubview:cell];
        if (right) {
            [self.hsy_containerViews addObject:cell];
            [self.hsy_scrollView setXPage:1];
        } else {
            [self.hsy_containerViews insertObject:cell atIndex:0];
            [self.hsy_scrollView setXPage:(self.hsy_scrollView.subviews.count - 1)];
        }
    }
    NSInteger newIndex = ((self.hsy_currentPage - 1) + self.hsy_pages.count) % self.hsy_pages.count;
    if (right) {
        newIndex = (self.hsy_currentPage + 1) % self.hsy_pages.count;
    }
    self.hsy_currentPage = newIndex;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    [self hsy_scrollEndScrolling:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self hsy_scrollEndScrolling:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hsy_scrollEndScrolling:scrollView];
}

- (void)hsy_scrollEndScrolling:(UIScrollView *)scrollView
{
    BOOL rightDirection = (self.hsy_scrollView.scrollHorizontalDirection == kHSYCocoaKitScrollDirectionToRight ? YES : NO);
    [self scrollDirection:rightDirection];
}

#pragma mark - HSYCustomBannerBaseCellDelegate

- (void)hsy_customBannerBaseCell:(HSYCustomBannerBaseCell *)cell
{
    if (self.hsy_delegate && [self.hsy_delegate respondsToSelector:@selector(hsy_revisionBannerView:didSelectPageAtIndex:)]) {
        [self.hsy_delegate hsy_revisionBannerView:self didSelectPageAtIndex:self.hsy_scrollView.currentPage];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
