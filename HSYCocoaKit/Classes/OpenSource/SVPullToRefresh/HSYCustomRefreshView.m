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

#define REFRESH_WILL_START_TITLE            @"下拉刷新"
#define REFRESH_RELEASE_START_TITLE         @"放开后立即更新"
#define REFRESH_LOADING_TITLE               @"正在刷新..."
#define REFRESH_UPDATE_OVER_TITLE           @"刷新完毕"

@interface HSYCustomRefreshView ()

@property (nonatomic, strong) UILabel *refreshTitleLabel;

@end

@implementation HSYCustomRefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        [self addSubview:self.contentView];
    }
    return self;
}

#pragma mark - Set Pull Down Background Color

- (void)updateBackgroundColor:(UIColor *)color
{
    
}

#pragma mark - Observer Scroll Percent

- (void)updateTriggerForPercent:(CGFloat)percent refreshState:(SVPullToRefreshState)state
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

- (void)start
{
    [self updateTriggerForPercent:MAX_TRIGGER_PERCENT refreshState:SVPullToRefreshStateLoading];
}

#pragma mark - Stop Loading Animation

- (void)stop
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
