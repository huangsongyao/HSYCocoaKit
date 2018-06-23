//
//  HSYCustomRefreshView.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYCustomRefreshView.h"
#import "NSObject+UIKit.h"
#import "UILabel+SuggestSize.h"
#import "UIView+Frame.h"
#import "Masonry.h"
#import "PublicMacroFile.h"
#import "SVPullToRefresh.h"

#define REFRESH_WILL_START_TITLE            @"下拉刷新"
#define REFRESH_WILL_START_UP_TITLE         @"上拉加载更多数据"
#define REFRESH_RELEASE_START_TITLE         @"放开后立即更新"
#define REFRESH_RELEASE_START_UP_TITLE      @"放开后立即加载更多数据"
#define REFRESH_LOADING_TITLE               @"正在刷新..."
#define REFRESH_UPDATE_OVER_TITLE           @"刷新完毕"

@interface HSYCustomRefreshView ()

@property (nonatomic, strong) UILabel *hsy_refreshTitleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *hsy_indicatorView;
@property (nonatomic, strong) UIView *hsy_backgroundView;
@property (nonatomic, assign, readonly) BOOL isPullDown;

@end

@implementation HSYCustomRefreshView

- (instancetype)initWithRefreshDown:(BOOL)down
{
    if (self = [super initWithFrame:CGRectZero]) {
        _isPullDown = down;
        self.backgroundColor = CLEAR_COLOR;
        //上拉或者下拉的无限背景
        self.hsy_backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.hsy_backgroundView.backgroundColor = WHITE_COLOR;
        [self addSubview:self.hsy_backgroundView];
        [self.hsy_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            if (down) {
                make.bottom.equalTo(self.mas_bottom);
                make.top.equalTo(self.mas_top).offset(-IPHONE_HEIGHT);
            } else {
                make.top.equalTo(self.mas_top);
                make.bottom.equalTo(self.mas_bottom).offset(IPHONE_HEIGHT);
            }
        }];
        
        //提示说明文字
        UIFont *font = UI_SYSTEM_FONT_15;
        CGFloat width = 200.0f;
        NSDictionary *dic = @{
                              @(kHSYCocoaKitOfLabelPropretyTypeText) : (down ? REFRESH_WILL_START_TITLE : REFRESH_WILL_START_UP_TITLE),
                              @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : font,
                              @(kHSYCocoaKitOfLabelPropretyTypeFrame) : [NSValue valueWithCGRect:CGRectMake((IPHONE_WIDTH - width)/2, 0, width, SVInfiniteScrollingViewHeight)],
                              @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentCenter),
                              };
        self.hsy_refreshTitleLabel = [NSObject createLabelByParam:dic];
        [self addSubview:self.hsy_refreshTitleLabel];
        
        //加载的菊花
        self.hsy_indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.hsy_indicatorView.center = self.hsy_refreshTitleLabel.center;
        [self addSubview:self.hsy_indicatorView];
        [self bringSubviewToFront:self.hsy_indicatorView];
    }
    return self;
}

#pragma mark - Set Pull Down Background Color

- (void)hsy_updateLongTopBackgroundColor:(UIColor *)color
{
    self.hsy_backgroundView.backgroundColor = color;
}

#pragma mark - Observer Scroll Percent

- (void)hsy_updatePullDownTriggerForPercent:(CGFloat)percent
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    if (percent >= MID_TRIGGER_PERCENT) {
        self.hsy_refreshTitleLabel.text = REFRESH_RELEASE_START_TITLE;
    } else {
        self.hsy_refreshTitleLabel.text = REFRESH_WILL_START_TITLE;
    }
    [CATransaction commit];
}

- (void)hsy_updatePullUpTriggerForPercent:(CGFloat)percent
{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    if (percent > MAX_TRIGGER_UP_PERCENT) {
        self.hsy_refreshTitleLabel.text = REFRESH_RELEASE_START_UP_TITLE;
    } else {
        self.hsy_refreshTitleLabel.text = REFRESH_WILL_START_UP_TITLE;
    }
    [CATransaction commit];
}

#pragma mark - Start Loading Animation

- (void)hsy_start
{
    self.hsy_refreshTitleLabel.hidden = YES;
    if (!self.hsy_indicatorView.isAnimating) {
        [self.hsy_indicatorView startAnimating];
    }
}

#pragma mark - Stop Loading Animation

- (void)hsy_stop
{
    self.hsy_refreshTitleLabel.hidden = NO;
    if (self.hsy_indicatorView.isAnimating) {
        [self.hsy_indicatorView stopAnimating];
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
