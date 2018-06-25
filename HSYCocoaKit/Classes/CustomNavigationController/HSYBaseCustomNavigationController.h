//
//  HSYBaseCustomNavigationController.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <UIKit/UIKit.h>
#import "HSYCustomLeftTransitionAnimation.h"
#import "PublicMacroFile.h"

typedef NS_ENUM(NSUInteger, kHSYCustomNavigationControllerParamsKey) {
    
    kHSYCustomNavigationControllerParamsKeyEndedProgress,                       //设置交互手势结束后判断位置的比例的key---NSNumber--CGFloat
    kHSYCustomNavigationControllerParamsKeyOpenTransitionAnimation,             //设置是否打开自定义的转场动画的key---NSNumber--BOOL
    kHSYCustomNavigationControllerParamsKeyAnimationType,                       //转场动画类型的key---NSNumber--kHSYCustomNavigationControllerPushAnimation
    
};

typedef NS_ENUM(NSUInteger, kHSYCustomNavigationControllerPushAnimation) {
    
    kHSYCustomNavigationControllerPushAnimationCardPush,                        //放缩卡片式动画
    kHSYCustomNavigationControllerPushAnimationSystemPush,                      //系统式侧滑动画
    
};

@interface HSYBaseCustomNavigationController : UINavigationController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

//设置是否打开自定义转场动画
@property (nonatomic, assign, setter=openCustomTransitionAnimation:) BOOL openTransitionAnimation NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);
//滑动手势结束后的判定比例，取值范围为[0, 1]，闭区间，默认为0.65
@property (nonatomic, assign, readonly) CGFloat panGestureEndedProgress NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);
//转场动画交互手势是否结束
@property (nonatomic, assign, readonly) BOOL tranistionCompleted NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);
//是否禁止转场交互手势，包含了定制格式和系统格式，用于特定页面禁止侧滑
@property (nonatomic, assign) BOOL banTransition NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);
//当前的转场动画类型
@property (nonatomic, assign, readonly) kHSYCustomNavigationControllerPushAnimation animation NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

//此入口方法默认打开了自定义转场动画
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
                                    params:(NSDictionary <NSNumber *, id>*)params NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
