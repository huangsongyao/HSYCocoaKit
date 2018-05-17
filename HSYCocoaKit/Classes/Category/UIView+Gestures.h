//
//  UIView+Gestures.h
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Gestures)

/**
 添加单击手势，手指数1，单击次数1

 @param delegate 委托
 @param next 点击回调事件
 */
- (void)hsy_addTapGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next;

@end
