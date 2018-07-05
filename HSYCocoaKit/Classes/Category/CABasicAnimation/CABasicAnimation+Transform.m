//
//  CABasicAnimation+Transform.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/22.
//

#import "CABasicAnimation+Transform.h"

@implementation CABasicAnimation (Transform)

+ (CABasicAnimation *)hsy_animationByKeyPath:(NSString *)keyPath
                                    duration:(NSTimeInterval)duration
                                    formValue:(CGFloat)formValue
                                      toValue:(CGFloat)toValue
                          removedOnCompletion:(BOOL)reset
                                 autoreverses:(BOOL)autoreverses
                                  repeatCount:(NSInteger)count
{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = @(formValue);
    animation.toValue = @(toValue);
    animation.duration = duration;
    animation.autoreverses = autoreverses;
    animation.removedOnCompletion = reset;
    if (!reset) {
        animation.fillMode = kCAFillModeForwards;
    }
    animation.repeatCount = count;
    return animation;
}

+ (CABasicAnimation *)hsy_rotatingAnimationForDuration:(NSTimeInterval)duration
                                             formValue:(CGFloat)formValue
                                               toValue:(CGFloat)toValue
                                   removedOnCompletion:(BOOL)reset
                                          autoreverses:(BOOL)autoreverses
                                           repeatCount:(NSInteger)count
{
    CABasicAnimation *animation = [CABasicAnimation hsy_animationByKeyPath:@"transform.rotation.z"
                                                                  duration:duration
                                                                 formValue:formValue
                                                                   toValue:toValue
                                                       removedOnCompletion:reset
                                                              autoreverses:autoreverses
                                                               repeatCount:count];
    return animation;
}

+ (CABasicAnimation *)hsy_translationAnimationForDuration:(NSTimeInterval)duration
                                                formValue:(CGFloat)formValue
                                                  toValue:(CGFloat)toValue
                                      removedOnCompletion:(BOOL)reset
                                              repeatCount:(NSInteger)count
                                           timingFunction:(CAMediaTimingFunction *)function
{
    CABasicAnimation *animation = [CABasicAnimation hsy_animationByKeyPath:@"transform.translation.y"
                                                                  duration:duration
                                                                 formValue:formValue
                                                                   toValue:toValue
                                                       removedOnCompletion:reset
                                                              autoreverses:NO
                                                               repeatCount:count];
    return animation;
}

@end
