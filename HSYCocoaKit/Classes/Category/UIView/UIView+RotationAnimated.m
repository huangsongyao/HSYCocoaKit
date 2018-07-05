//
//  UIView+RotationAnimated.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/19.
//

#import "UIView+RotationAnimated.h"
#import "CABasicAnimation+Transform.h"

static NSTimeInterval kHSYCocoaKitDefaultRotatingDuration   = 0.2f;

NSString *const kHSYCocoaKitDefaultSingleRotatingKey        = @"nfsieposnefi3if3fopa";
NSString *const kHSYCocoaKitDefaultInfiniteRotatingKey      = @"o9fejfoejfefoesfjoef";

@implementation UIView (RotationAnimated)

/**
 transform.rotation.z下的CABasicAnimation动画

 @param duration 单次动画执行时间
 @param formValue 改变的起始值
 @param toValue 改变的终止值
 @param reset 动画执行完毕后知否复原
 @param autoreverses 动画结束时是否执行逆动画
 @param count 动画执行次数，无限执行请传入“HUGE_VALF”
 @param key 动画的key值
 */
- (void)rotatingAnimationForDuration:(NSTimeInterval)duration
                           formValue:(CGFloat)formValue
                             toValue:(CGFloat)toValue
                 removedOnCompletion:(BOOL)reset
                        autoreverses:(BOOL)autoreverses
                         repeatCount:(NSInteger)count
                              forKey:(NSString *)key
{
    CABasicAnimation *animation =  [CABasicAnimation hsy_rotatingAnimationForDuration:duration formValue:formValue toValue:toValue removedOnCompletion:reset autoreverses:autoreverses repeatCount:count];
    [self.layer addAnimation:animation forKey:key];
}

#pragma mark - Infinite Rotating

- (void)hsy_infiniteRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue
{
    [self hsy_infiniteRotatingFromValue:fromValue
                                toValue:toValue
                      animationDuration:[UIView hsy_rotatingAnimationDuration]];
}

- (void)hsy_infiniteRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue animationDuration:(NSTimeInterval)duration
{
    [self rotatingAnimationForDuration:duration
                             formValue:fromValue
                               toValue:toValue
                   removedOnCompletion:NO
                          autoreverses:NO
                           repeatCount:HUGE_VALF
                                forKey:kHSYCocoaKitDefaultInfiniteRotatingKey];
}

- (void)hsy_removeInfiniteRotating
{
    [self.layer removeAnimationForKey:kHSYCocoaKitDefaultInfiniteRotatingKey];
}

#pragma mark - Single Rotating

- (void)hsy_singleRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue
{
    [self hsy_singleRotatingFromValue:fromValue
                              toValue:toValue
                    animationDuration:[UIView hsy_rotatingAnimationDuration]];
}

- (void)hsy_singleRotatingFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue animationDuration:(NSTimeInterval)duration
{
    [self rotatingAnimationForDuration:duration
                             formValue:fromValue
                               toValue:toValue
                   removedOnCompletion:NO
                          autoreverses:NO
                           repeatCount:1
                                forKey:kHSYCocoaKitDefaultSingleRotatingKey];
}

- (void)hsy_removeSingleRotating
{
    [self.layer removeAnimationForKey:kHSYCocoaKitDefaultSingleRotatingKey];
}

#pragma mark - Animation Duration

+ (NSTimeInterval)hsy_rotatingAnimationDuration
{
    return kHSYCocoaKitDefaultRotatingDuration;
}

@end
