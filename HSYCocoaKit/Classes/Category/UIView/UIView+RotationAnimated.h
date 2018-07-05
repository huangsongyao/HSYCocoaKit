//
//  UIView+RotationAnimated.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kHSYCocoaKitDefaultSingleRotatingKey;     //单次非逆向非复原动画key
FOUNDATION_EXPORT NSString *const kHSYCocoaKitDefaultInfiniteRotatingKey;   //无限次非逆向非复原动画key

@interface UIView (RotationAnimated)

/**
 开启无限次旋转动画，默认单次动画时长为“kHSYCocoaKitDefaultRotatingDuration”

 @param fromValue 动画起始值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 @param toValue 动画终止值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 */
- (void)hsy_infiniteRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

/**
 开启无限次旋转动画

 @param fromValue 动画起始值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 @param toValue 动画终止值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 @param duration 动画时长
 */
- (void)hsy_infiniteRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue animationDuration:(NSTimeInterval)duration;

/**
 移除“- hsy_infiniteRotatingFromValue:toValue:”无限次旋转动画
 */
- (void)hsy_removeInfiniteRotating;

/**
 开启单次旋转动画，默认单次动画时长为“kHSYCocoaKitDefaultRotatingDuration”

 @param fromValue 动画起始值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 @param toValue 动画终止值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 */
- (void)hsy_singleRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

/**
 开启单次旋转动画

 @param fromValue 动画起始值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 @param toValue 动画终止值，由于是绕圆心的旋转，所以一般取值为：0.0f---(2 * M_PI)
 @param duration 动画时长
 */
- (void)hsy_singleRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue animationDuration:(NSTimeInterval)duration;

/**
 移除“- hsy_singleRotatingFromValue:toValue:”单次旋转动画
 */
- (void)hsy_removeSingleRotating;

@end
