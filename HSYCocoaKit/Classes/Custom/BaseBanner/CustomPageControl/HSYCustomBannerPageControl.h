//
//  HSYCustomBannerPageControl.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitCustomBannerPageControl) {
    
    kHSYCocoaKitCustomBannerPageControlNumberOfPages                    = 456,  //总数--NSNumber--NSInteger
    kHSYCocoaKitCustomBannerPageControlCurrentPage,                             //当前页面--NSNumber--NSInteger
    kHSYCocoaKitCustomBannerPageControlPageIndicatorTintColor,                  //未选中的颜色--UIColor
    kHSYCocoaKitCustomBannerPageControlCurrentPageIndicatorTintColor,           //选中项的颜色--UIColor
    
};

@interface HSYCustomBannerPageControl : UIPageControl

- (instancetype)initWithParamter:(NSDictionary<NSNumber *, id> *)param;

/**
 点的高度，允许子类重写本方法，定制高度，默认为3.0f
 
 @return 点的高度
 */
+ (CGFloat)hsy_defaultPageControlPointHeight;

/**
 选中的点的宽度，允许子类重写本方法，定制高度，默认为10.0f
 
 @return 选中的点的宽度
 */
+ (CGFloat)hsy_defaultPageControlPointSelectedPointWidth;

/**
 点与点之间的间距，允许子类重写本方法，定制高度，默认为5.0f
 
 @return 点与点之间的间距
 */
+ (CGFloat)hsy_defaultPageControlPointMagrin;

@end
