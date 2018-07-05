//
//  UIViewController+QRCode.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/22.
//

#import "UIViewController+QRCode.h"
#import "UIView+Frame.h"
#import "CABasicAnimation+Transform.h"

@implementation UIViewController (QRCode)

- (void)qrCodeScaningAnimation:(CGFloat)toValue onLayer:(CALayer *)layer forKey:(NSString *)key
{
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CABasicAnimation *animation = [CABasicAnimation hsy_translationAnimationForDuration:2.0f
                                                                              formValue:0
                                                                                toValue:toValue
                                                                    removedOnCompletion:YES
                                                                            repeatCount:HUGE_VALL
                                                                         timingFunction:function];
    [layer addAnimation:animation forKey:key];
}

- (CGRect)qrCodeScaningZone:(CGRect)boxCGRect
{
    CGFloat fullWidth = self.view.width;
    CGFloat fullHeight = self.view.height;
    
    CGFloat x = CGRectGetMinX(boxCGRect);
    CGFloat y = CGRectGetMinY(boxCGRect);
    
    CGFloat width = CGRectGetWidth(boxCGRect);
    CGFloat height = CGRectGetHeight(boxCGRect);
    
    if (x + width > fullWidth) {
        if (width > fullWidth) {
            width = fullWidth;
        } else {
            x = 0;
        }
    }
    
    if (y + height > fullHeight) {
        if (height > fullHeight) {
            height = fullHeight;
        } else {
            y = 0;
        }
    }
    
    CGFloat validZoneX = (fullWidth - width - x) / fullWidth;
    CGFloat validZoneY = y / fullHeight;
    CGFloat validZoneWidth = width / fullWidth;
    CGFloat validZoneHeight = height / fullHeight;
    
    return CGRectMake(validZoneY, validZoneX, validZoneHeight, validZoneWidth);
}

@end
