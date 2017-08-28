//
//  NSObject+Transition.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

#define MAX_ALPHA_COMPONENT                 0.6f
#define MIN_ALPHA_COMPONENT                 0.0f

#define PUSH_FROM_VIEW_OFFSET_X             15.0f
#define PUSH_FROM_VIEW_OFFSET_Y             20.0f

#define FIRST_VC_DEFAULT_FRAME              CGRectMake(PUSH_FROM_VIEW_OFFSET_X, PUSH_FROM_VIEW_OFFSET_Y, IPHONE_WIDTH - PUSH_FROM_VIEW_OFFSET_X*2, IPHONE_HEIGHT - PUSH_FROM_VIEW_OFFSET_Y*2)

@interface NSObject (Transition)

/**
 *  push动画
 *
 *  @param viewController push到的控制器
 *  @param duration       动画时间
 *  @param animations     动画内容
 *  @param completion     动画完成后的回调
 */
- (void)pushToViewController:(UIViewController *)viewController transitionDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

/**
 *  pop动画
 *
 *  @param viewController pop回去的控制器
 *  @param duration       动画时间
 *  @param animations     动画内容
 *  @param completion     动画完成的回调
 */
- (void)popFromViewController:(UIViewController *)viewController transitionDuration:(NSTimeInterval)duration animations:(void(^)())animations completion:(void(^)(BOOL finished))completion;

@end
