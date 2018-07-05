//
//  CABasicAnimation+Transform.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/22.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimation (Transform)

/**
 [transform.rotation.z]--路径下的旋转动画

 @param duration 单次动画市场
 @param formValue 动画起始值
 @param toValue 动画终止值
 @param reset 动画执行完毕后知否复原
 @param autoreverses 动画结束时是否执行逆动画
 @param count 动画执行次数，无限执行请传入“HUGE_VALF”
 @return CABasicAnimation
 */
+ (CABasicAnimation *)hsy_rotatingAnimationForDuration:(NSTimeInterval)duration
                                             formValue:(CGFloat)formValue
                                               toValue:(CGFloat)toValue
                                   removedOnCompletion:(BOOL)reset
                                          autoreverses:(BOOL)autoreverses
                                           repeatCount:(NSInteger)count;

/**
 [transform.translation.y]--路径下的移动动画，动画结束后不执行逆向动画

 @param duration 单次动画市场
 @param formValue 动画起始值
 @param toValue 动画终止值
 @param reset 动画执行完毕后知否复原
 @param count 动画执行次数，无限执行请传入“HUGE_VALF”
 @param function CAMediaTimingFunction类，用于动画时的线性缓冲
 @return CABasicAnimation
 */
+ (CABasicAnimation *)hsy_translationAnimationForDuration:(NSTimeInterval)duration
                                                formValue:(CGFloat)formValue
                                                  toValue:(CGFloat)toValue
                                      removedOnCompletion:(BOOL)reset
                                              repeatCount:(NSInteger)count
                                           timingFunction:(CAMediaTimingFunction *)function;
@end
