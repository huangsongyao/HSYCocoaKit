//
//  HSYBasePageScrollView.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2019/3/4.
//

#import "HSYBasePageScrollView.h"
#import "ReactiveCocoa.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"

@implementation HSYBasePageTableView

- (instancetype)initWithTableHeaderView:(UIView *)tableHeaderView
{
    if (self = [super initWithFrame:CGRectZero style:UITableViewStylePlain]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.tableHeaderView = tableHeaderView;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end

//*********************************************************************************************************

@interface HSYBasePageScrollView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL scrollDidCriticalValue;
@property (nonatomic, assign) BOOL mainViewScrollState;
@property (nonatomic, assign) BOOL listViewScrollState;
@property (nonatomic, strong) NSArray<id<HSYBasePageTableDelegate>> *listViewPages;

@end

@implementation HSYBasePageScrollView

- (instancetype)initWithDelegate:(id<HSYBasePageScrollDelegate>)delegate
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT)]) {
        
        self.scrollDidCriticalValue = NO;
        self.mainViewScrollState = YES;
        self.listViewScrollState = NO;
        
        self.hsy_delegate = delegate;
        UIView *tableHeaderView = [self.hsy_delegate hsy_tableHeaderViewInPageScrollView:self];
        _hsy_mainTableView = [[HSYBasePageTableView alloc] initWithTableHeaderView:tableHeaderView];
        self.hsy_mainTableView.frame = self.bounds;
        self.hsy_mainTableView.delegate = self;
        self.hsy_mainTableView.dataSource = self;
        [self addSubview:self.hsy_mainTableView];
        
        self.listViewPages = [self.hsy_delegate hsy_listViewsInPageScrollView:self];
        @weakify(self);
        [self.listViewPages enumerateObjectsUsingBlock:^(id<HSYBasePageTableDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj hsy_listScrollViewDidScroll:^(UIScrollView * _Nonnull scrollView) {
                @strongify(self);
                [self listScrollViewDidScroll:scrollView];
            }];
        }];
    }
    return self;
}

#pragma mark - Setter

- (void)startHorizonScroll:(BOOL)userHorizonScroll
{
    _userHorizonScroll = userHorizonScroll;
    self.hsy_mainTableView.scrollEnabled = userHorizonScroll;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self numberOfSectionsInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kHSYCocoaKitPageMainScrollCellIdentifier = @"HSYCocoaKitPageMainScrollCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHSYCocoaKitPageMainScrollCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kHSYCocoaKitPageMainScrollCellIdentifier];
    }
    UIView *contentView = [self.hsy_delegate hsy_pageViewInPageScrollView:self];
    [cell.contentView addSubview:contentView];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.hsy_delegate hsy_listViewHeightInPageScrollView:self];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self mainScrollViewDidScroll:scrollView];
    if (self.hsy_delegate && [self.hsy_delegate respondsToSelector:@selector(hsy_mainTableViewDidScroll:)]) {
        [self.hsy_delegate hsy_mainTableViewDidScroll:scrollView];
    }
}

- (void)mainScrollViewDidScroll:(UIScrollView *)scrollView
{
    //获取mainScrollview偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat criticalPoint = [self.hsy_mainTableView rectForSection:0].origin.y - self.criticalScrollValue;
    
    // 根据偏移量判断是否上滑到临界点
    self.scrollDidCriticalValue = (offsetY >= criticalPoint);
    if (self.scrollDidCriticalValue) {
        //上滑到临界点后，固定其位置
        scrollView.contentOffset = CGPointMake(0.0f, criticalPoint);
        self.mainViewScrollState = NO;
        self.listViewScrollState = YES;
    } else {
        if (self.mainViewScrollState) {
            //未达到临界点，mainScrollview可滑动，需要重置所有listScrollView的位置
            [self.listViewPages enumerateObjectsUsingBlock:^(id<HSYBasePageTableDelegate>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIScrollView *listScrollView = [obj hsy_listScrollView];
                listScrollView.contentOffset = CGPointZero;
                listScrollView.showsVerticalScrollIndicator = NO;
            }];
        } else {
            //未到达临界点，mainScrollview不可滑动，固定其位置
            scrollView.contentOffset = CGPointMake(0.0f, criticalPoint);
        }
    }
}

- (void)listScrollViewDidScroll:(UIScrollView *)scrollView
{
    //如果禁止listScrollview滑动，则固定其位置
    if (!self.listViewScrollState) {
        scrollView.contentOffset = CGPointZero;
    }
    //获取listScrollview偏移量
    CGFloat offsetY = scrollView.contentOffset.y;
    //listScrollView下滑至offsetY小于0，禁止其滑动，让mainTableView可下滑
    if (offsetY < 0.0f) {
        self.mainViewScrollState = YES;
        self.listViewScrollState = NO;
        scrollView.contentOffset = CGPointZero;
        scrollView.showsVerticalScrollIndicator = NO;
    } else {
        if (self.listViewScrollState) {
            scrollView.showsVerticalScrollIndicator = YES;
        }
    }
}



@end
