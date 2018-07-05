//
//  HSYCustomLeftTransitionAnimation.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYCustomBaseTransitionAnimation.h"

@interface HSYCustomLeftTransitionAnimation : HSYCustomBaseTransitionAnimation

@property (nonatomic, assign) CGPoint hsy_transformScale;       //放缩动画的比例，hsy_transformScale.x表示宽度放缩比例，hsy_transformScale.y表示放缩高度比例，默认为(0.8f, 0.85f)

/**
 初始化
 
 @param type 动作枚举
 @return HSYCustomLeftTransitionAnimation
 */
- (instancetype)initWithCardBackTransitionType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
