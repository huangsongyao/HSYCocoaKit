//
//  HSYCustomBackTransitionAnimation.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/25.
//

#import <HSYCocoaKit/HSYCocoaKit.h>

@interface HSYCustomBackTransitionAnimation : HSYCustomBaseTransitionAnimation

@property (nonatomic, assign) CGFloat hsy_leftTransitionOffset;     //左侧偏移，默认为设备的宽度的1/3

/**
 初始化

 @param type 动作枚举
 @return HSYCustomBackTransitionAnimation
 */
- (instancetype)initWithSystemBackTransitionType:(kHSYCustomPercentDrivenInteractiveTransitionActionsType)type;

@end
