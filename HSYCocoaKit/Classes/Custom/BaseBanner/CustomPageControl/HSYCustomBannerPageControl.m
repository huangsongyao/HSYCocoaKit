//
//  HSYCustomBannerPageControl.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import "HSYCustomBannerPageControl.h"
#import "PublicMacroFile.h"
#import "UIView+Frame.h"

#define DEFAULT_PAGE_PIONT_HEIGHT           3.0f
#define DEFAULT_PAGE_PIONT_WIDHT            10.0f
#define DEFAULT_PAGE_PIONT_MAGRIN           5.0f

@implementation HSYCustomBannerPageControl

- (instancetype)initWithParamter:(NSDictionary<NSNumber *,id> *)param
{
    if (self = [super initWithSize:CGSizeMake(IPHONE_WIDTH, DEFAULT_PAGE_PIONT_HEIGHT)]) {
        if (param[@(kHSYCocoaKitCustomBannerPageControlNumberOfPages)]) {
            self.numberOfPages = [param[@(kHSYCocoaKitCustomBannerPageControlNumberOfPages)] integerValue];
        }
        if (param[@(kHSYCocoaKitCustomBannerPageControlCurrentPage)]) {
            self.currentPage = [param[@(kHSYCocoaKitCustomBannerPageControlCurrentPage)] integerValue];
        }
        if (param[@(kHSYCocoaKitCustomBannerPageControlPageIndicatorTintColor)]) {
            self.pageIndicatorTintColor = param[@(kHSYCocoaKitCustomBannerPageControlPageIndicatorTintColor)];
        }
        if (param[@(kHSYCocoaKitCustomBannerPageControlCurrentPageIndicatorTintColor)]) {
            self.currentPageIndicatorTintColor = param[@(kHSYCocoaKitCustomBannerPageControlCurrentPageIndicatorTintColor)];
        }
    }
    return self;
}

#pragma mark - Custom

+ (CGFloat)hsy_defaultPageControlPointHeight
{
    return DEFAULT_PAGE_PIONT_HEIGHT;
}

+ (CGFloat)hsy_defaultPageControlPointSelectedPointWidth
{
    return DEFAULT_PAGE_PIONT_WIDHT;
}

+ (CGFloat)hsy_defaultPageControlPointMagrin
{
    return DEFAULT_PAGE_PIONT_MAGRIN;
}

#pragma mark - Load

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat realWidth = (self.subviews.count - 1) * ([self.class hsy_defaultPageControlPointMagrin] + [self.class hsy_defaultPageControlPointHeight]) + [self.class hsy_defaultPageControlPointSelectedPointWidth];
    self.frame = CGRectMake((IPHONE_WIDTH - realWidth)/2, self.y, realWidth, self.height);
    self.center = CGPointMake(IPHONE_WIDTH/2, self.center.y);
    CGFloat x = 0.0f;
    for (NSUInteger i = 0; i < self.subviews.count; i ++) {
        UIView *subview = [self.subviews objectAtIndex:i];
        CGFloat width = [self.class hsy_defaultPageControlPointHeight];
        if (i == self.currentPage) {
            width = [self.class hsy_defaultPageControlPointSelectedPointWidth];
        }
        subview.frame = CGRectMake(x, subview.frame.origin.y, width, [self.class hsy_defaultPageControlPointHeight]);
        subview.layer.cornerRadius = CGRectGetHeight(subview.frame)/2;
        x = (CGRectGetMaxX(subview.frame) + [self.class hsy_defaultPageControlPointMagrin]);
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
