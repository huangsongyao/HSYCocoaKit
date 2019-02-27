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
#import "UIScrollView+SVInfiniteScrolling.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "NSString+Size.h"
#import "NSBundle+PrivateFileResource.h"
#import "UIView+RotationAnimated.h"
#import "UIImageView+Scale.h"

#define REFRESH_WILL_START_TITLE                @"下拉刷新"
#define REFRESH_WILL_START_UP_TITLE             @"上拉加载"
#define REFRESH_RELEASE_START_TITLE             @"松开立即更新"
#define REFRESH_LOADING_TITLE                   @"正在刷新..."
#define REFRESH_UP_LOADING_TITLE                @"正在加载..."
#define REFRESH_UPDATE_NOT_MORE                 @"已经到底了~"
#define MID_TRIGGER_PERCENT                     1.0f

static NSTimeInterval kHSYCocoaKitKefaultRefreshDuration        = 1.0f;
static NSInteger const kHSYCocoaKitReloadBackgroundImageTag     = 2324;

@interface HSYCustomRefreshView ()

@property (nonatomic, strong) UILabel *hsy_refreshTitleLabel;
@property (nonatomic, strong) UIActivityIndicatorView *hsy_indicatorView;
@property (nonatomic, strong) UIImageView *hsy_iconImageView;
@property (nonatomic, strong) UIView *hsy_backgroundView;
@property (nonatomic, assign, readonly) BOOL isPullDown;
@property (nonatomic, assign, readonly) BOOL allowIsDown;

@end

@implementation HSYCustomRefreshView

- (instancetype)initWithRefreshDown:(BOOL)down
{
    NSDictionary *heightDictionary = @{@(NO) : @(SVInfiniteScrollingViewHeight), @(YES) : @(SVPullToRefreshViewHeight), };
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, [heightDictionary[@(down)] floatValue])]) {
        _isPullDown = down;
        _allowIsDown = YES;
        _hsy_pullDownRotation = NO;
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
        
        //加载的菊花
        self.hsy_indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:self.hsy_indicatorView];
        [self bringSubviewToFront:self.hsy_indicatorView];
        [self.hsy_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset((IPHONE_WIDTH / 375.0f * [self.class hsy_refreshAllowOffsetLeft]));
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(self.hsy_indicatorView.size);
        }];
        
        //箭头
        UIImage *image = [self hsy_allowImage];
        self.hsy_iconImageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image, }];
        [self addSubview:self.hsy_iconImageView];
        [self.hsy_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.hsy_indicatorView);
        }];
        
        //提示说明文字
        NSDictionary *dic = @{ @(kHSYCocoaKitOfLabelPropretyTypeText) : (down ? [self.class hsy_refreshWillDownTitle] : [self.class hsy_refreshWillUpTitle]), @(kHSYCocoaKitOfLabelPropretyTypeTextFont) : [self.class hsy_titleFont],  @(kHSYCocoaKitOfLabelPropretyTypeTextAlignment) : @(NSTextAlignmentLeft), @(kHSYCocoaKitOfLabelPropretyTypeTextColor) : [self.class hsy_titleColor], };
        self.hsy_refreshTitleLabel = [NSObject createLabelByParam:dic];
        [self addSubview:self.hsy_refreshTitleLabel];
        [self.hsy_refreshTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hsy_iconImageView.mas_right).offset(10.0f);
            make.right.equalTo(self.mas_right).offset(-25.0f);
            make.centerY.equalTo(self.hsy_iconImageView.mas_centerY);
            make.height.equalTo(@(UI_SYSTEM_FONT_14.lineHeight + 10.0f));
        }];
    }
    return self;
}

#pragma mark - Set Pull Down Background Color & Image

- (void)hsy_updateLongTopBackgroundColor:(UIColor *)color
{
    self.hsy_backgroundView.backgroundColor = color;
}

- (void)hsy_updateLongTopBackgroundImage:(UIImage *)image
{
    UIImageView *imageView = [self.hsy_backgroundView viewWithTag:kHSYCocoaKitReloadBackgroundImageTag];
    if (!imageView) {
        imageView = [NSObject createImageViewByParam:@{@(kHSYCocoaKitOfImageViewPropretyTypeNorImageViewName) : image, @(kHSYCocoaKitOfImageViewPropretyTypePreImageViewName) : image, }];
        imageView.tag = kHSYCocoaKitReloadBackgroundImageTag;
        [self.hsy_backgroundView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hsy_backgroundView.mas_left);
            make.right.equalTo(self.hsy_backgroundView.mas_right);
            if (self.isPullDown) {
                make.bottom.equalTo(self.hsy_backgroundView.mas_bottom);
            } else {
                make.top.equalTo(self.hsy_backgroundView.mas_top);
            }
            make.height.equalTo(@([UIImageView hsy_scaleHeight:self.width image:image]));
        }];
    } else {
        imageView.image = image;
        imageView.highlightedImage = image;
    }
}

#pragma mark - Observer Scroll Percent

- (void)hsy_notMore
{
    [self hsy_stop];
    UIImage *image = [self.class hsy_completedImage];
    self.hsy_iconImageView.image = image;
    self.hsy_iconImageView.highlightedImage = image;
    self.hsy_refreshTitleLabel.text = [self.class hsy_refreshDidUpedCompleted];
}

- (void)hsy_hasMore
{
    [self hsy_hiddenAllowImageView:NO];
    self.hsy_refreshTitleLabel.text = [self.class hsy_refreshWillUpTitle];
}

- (void)hsy_loadingRefresh:(BOOL)isPullDown
{
    [self hsy_start];
    NSString *title = (isPullDown ? [self.class hsy_refreshDowningTitle] : [self.class hsy_refreshUpingTitle]);
    self.hsy_refreshTitleLabel.text = title;
}

- (void)hsy_updatePullDownTriggerForPercent:(CGFloat)percent
{
    BOOL isOverPercent = (percent >= [self.class hsy_triggerPercent]);
    NSString *title = (isOverPercent ? [self.class hsy_refreshDidDownedTitle] : [self.class hsy_refreshWillDownTitle]);
    self.hsy_refreshTitleLabel.text = title;
    if (self.hsy_pullDownRotation) {
        CGFloat toAngle = MIN(((M_PI) * percent), (M_PI)) + M_PI;
        self.hsy_iconImageView.transform = HSYCOCOAKIT_GGA_ROTATION(toAngle);
    } else {
        if (isOverPercent && self.allowIsDown) {
            _allowIsDown = NO;
            [self.hsy_iconImageView hsy_singleRotatingFromValue:M_PI toValue:0.0f];
        } else if (!isOverPercent && !self.allowIsDown) {
            _allowIsDown = YES;
            [self.hsy_iconImageView hsy_singleRotatingFromValue:0.0f toValue:M_PI];
        }
    }
}

- (void)hsy_updatePullUpTriggerForPercent:(CGFloat)percent
{
    //load 
}

#pragma mark - Animation

- (void)hsy_start
{
    [self hsy_hiddenAllowImageView:YES];
    if (!self.hsy_indicatorView.isAnimating) {
        [self.hsy_indicatorView startAnimating];
    }
}

- (void)hsy_stop
{
    [self hsy_hiddenAllowImageView:NO];
    if (self.hsy_indicatorView.isAnimating) {
        [self.hsy_indicatorView stopAnimating];
    }
}

- (void)hsy_hiddenAllowImageView:(BOOL)hidden
{
    UIImage *image = [self hsy_allowImage];
    self.hsy_iconImageView.hidden = hidden;
    self.hsy_iconImageView.image = image;
    self.hsy_iconImageView.highlightedImage = image;
}

#pragma mark - Load

+ (NSString *)hsy_refreshWillDownTitle
{
    return REFRESH_WILL_START_TITLE;
}

+ (NSString *)hsy_refreshDowningTitle
{
    return REFRESH_LOADING_TITLE;
}

+ (NSString *)hsy_refreshDidDownedTitle
{
    return REFRESH_RELEASE_START_TITLE;
}

+ (NSString *)hsy_refreshWillUpTitle
{
    return REFRESH_WILL_START_UP_TITLE;
}

+ (NSString *)hsy_refreshUpingTitle
{
    return REFRESH_UP_LOADING_TITLE;
}

+ (NSString *)hsy_refreshDidUpedCompleted
{
    return REFRESH_UPDATE_NOT_MORE;
}

+ (CGFloat)hsy_refreshAllowOffsetLeft
{
    return 134.0f;
}

+ (UIColor *)hsy_titleColor
{
    return RGB(142, 142, 147);
}

+ (UIFont *)hsy_titleFont
{
    return UI_SYSTEM_FONT_14;
}

- (UIImage *)hsy_allowImage
{
    return [NSBundle imageForBundle:(self.isPullDown ? @"down_refresh" : @"ic_up")];
}

+ (UIImage *)hsy_completedImage
{
    return [NSBundle imageForBundle:@"ic_end"];
}

+ (CGFloat)hsy_triggerPercent
{
    return MID_TRIGGER_PERCENT;
}

#pragma mark - Getter

- (NSTimeInterval)hsy_loadRefreshDuration
{
    if (!_hsy_loadRefreshDuration) {
        _hsy_loadRefreshDuration = kHSYCocoaKitKefaultRefreshDuration;
    }
    return _hsy_loadRefreshDuration;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
