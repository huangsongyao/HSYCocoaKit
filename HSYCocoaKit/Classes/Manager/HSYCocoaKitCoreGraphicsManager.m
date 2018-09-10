//
//  HSYCocoaKitCoreGraphicsManager.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/7.
//

#import "HSYCocoaKitCoreGraphicsManager.h"

@implementation HSYCocoaKitCoreGraphicsManager

+ (void)hsy_contextRefGraphicsCircular:(UIColor *)fillColor circularCGRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, fillColor.CGColor);
    CGContextAddEllipseInRect(contextRef, rect);
 
    CGContextDrawPath(contextRef, kCGPathEOFill);
    CGContextRelease(contextRef);
}

@end
