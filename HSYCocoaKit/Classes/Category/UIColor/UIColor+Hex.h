//
//  UIColor+Hex.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

@property (nonatomic, readonly) CGColorSpaceModel   colorSpaceModel;

@property (nonatomic, readonly) BOOL                canProvideRGBComponents;
@property (nonatomic, readonly) UInt32              rgbHex;

@property (nonatomic, readonly) CGFloat red;    // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green;  // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue;   // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white;  // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha;

- (BOOL)red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a;
- (NSString *)hexStringFromColor;

+ (UIColor *)colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

@end
