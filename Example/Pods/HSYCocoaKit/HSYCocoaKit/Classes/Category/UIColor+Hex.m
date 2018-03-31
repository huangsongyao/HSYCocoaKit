//
//  UIColor+Hex.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

- (CGColorSpaceModel)colorSpaceModel
{    
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (BOOL)canProvideRGBComponents
{
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (UInt32)rgbHex
{
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    CGFloat r, g, b, a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(self.red, 0.0f), 1.0f);
    g = MIN(MAX(self.green, 0.0f), 1.0f);
    b = MIN(MAX(self.blue, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16) | (((int)roundf(g * 255)) << 8) | (((int)roundf(b * 255)));
}

- (CGFloat)red
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue
{
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)white
{
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)alpha
{
    return CGColorGetAlpha(self.CGColor);
}


+ (UIColor *)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [UIColor colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [UIColor colorWithRGBHex:hexNum alpha:alpha];
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    CGFloat r,g,b,a;
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome: {
            r = g = b = components[0];
            a = components[1];
        }
            break;
        case kCGColorSpaceModelRGB: {
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
        }
            break;
        default:
            return NO;
    }
    
    if (red)    *red    = r;
    if (green)  *green  = g;
    if (blue)   *blue   = b;
    if (alpha)  *alpha  = a;
    
    return YES;
}

- (NSString *)hexStringFromColor
{
    return [NSString stringWithFormat:@"%0.6X", (unsigned int)self.rgbHex];
}

+ (UIColor *)colorWithHex:(long)hexColor
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

@end
