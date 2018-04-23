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

#define REFRESH_WILL_START_TITLE            @"下拉刷新"
#define REFRESH_RELEASE_START_TITLE         @"放开后立即更新"
#define REFRESH_LOADING_TITLE               @"正在刷新..."
#define REFRESH_UPDATE_OVER_TITLE           @"刷新完毕"

@interface HSYCustomRefreshView ()

@property (nonatomic, strong) UILabel *refreshTitleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation HSYCustomRefreshView

- (instancetype)initWithRefreshDown:(BOOL)down
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.backgroundColor = CLEAR_COLOR;
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.backgroundView.backgroundColor = WHITE_COLOR;
        [self addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        self.contentView.backgroundColor = self.backgroundColor;
        [self addSubview:self.contentView];
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        [self addSubview:self.indicatorView];
        
        self.refreshTitleLabel = [NSObject createLabelByParam:@{}];
        [self addSubview:self.refreshTitleLabel];
    }
    return self;
}

#pragma mark - Set Pull Down Background Color

- (void)hsy_updateLongTopBackgroundColor:(UIColor *)color
{
    self.backgroundView.backgroundColor = color;
}

#pragma mark - Observer Scroll Percent

- (void)hsy_updateTriggerForPercent:(CGFloat)percent refreshState:(SVPullToRefreshState)state
{
    NSParameterAssert(!(percent < MIN_TRIGGER_PERCENT || percent > MAX_TRIGGER_PERCENT));
    if (!self.contentView) {
        return;
    }
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    if (percent == MAX_TRIGGER_PERCENT) {
        self.refreshTitleLabel.text = REFRESH_LOADING_TITLE;
    } else if (percent >= MID_TRIGGER_PERCENT) {
        self.refreshTitleLabel.text = REFRESH_RELEASE_START_TITLE;
    } else {
        self.refreshTitleLabel.text = REFRESH_WILL_START_TITLE;
    }
    [CATransaction commit];
}

#pragma mark - Start Loading Animation

- (void)hsy_start
{
    [self hsy_updateTriggerForPercent:MAX_TRIGGER_PERCENT refreshState:SVPullToRefreshStateLoading];
}

#pragma mark - Stop Loading Animation

- (void)hsy_stop
{
    self.refreshTitleLabel.text = REFRESH_UPDATE_OVER_TITLE;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
