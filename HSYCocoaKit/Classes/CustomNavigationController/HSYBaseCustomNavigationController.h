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
    
    kHSYCustomNavigationControllerParamsKeyEndedProgress,                       //设置交互手势结束后判断位置的比例的key
    kHSYCustomNavigationControllerParamsKeyOpenTransitionAnimation,             //设置是否打开自定义的转场动画的key
};


@interface HSYBaseCustomNavigationController : UINavigationController <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign, setter=openCustomTransitionAnimation:) BOOL openTransitionAnimation;                      //设置是否打开自定义转场动画
@property (nonatomic, assign) CGFloat panGestureEndedProgress;                                                          //滑动手势结束后的判定比例，取值范围为[0, 1]，闭区间，默认为0.65
@property (nonatomic, assign, readonly) BOOL tranistionCompleted;
@property (nonatomic, assign) BOOL banTransition;                                     //默认为NO，如果设置为YES，则不自持手势转场，用于特定页面禁止侧滑

//此入口方法默认打开了自定义转场动画
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController params:(NSDictionary <NSNumber *, id>*)params;

@end
