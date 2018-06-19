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
 开启无限次旋转动画

 @param fromValue 动画起始值
 @param toValue 动画终止值
 */
- (void)hsy_infiniteRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

/**
 移除“- hsy_infiniteRotatingFromValue:toValue:”无限次旋转动画
 */
- (void)hsy_removeInfiniteRotating;

/**
 开启单次旋转动画

 @param fromValue 动画起始值
 @param toValue 动画终止值
 */
- (void)hsy_singleRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

/**
 移除“- hsy_singleRotatingFromValue:toValue:”单次旋转动画
 */
- (void)hsy_removeSingleRotating;

@end
