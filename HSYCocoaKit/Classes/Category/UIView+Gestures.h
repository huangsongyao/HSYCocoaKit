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
 添加单指单击手势，手指数1，单击次数1

 @param delegate 委托
 @param next 单指单击回调事件
 */
- (void)hsy_addTapGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next;

/**
 添加单指双击手势，手指数1，单击次数2

 @param delegate 委托
 @param next 单指双击击回调事件
 */
- (void)hsy_addDoubleGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UITapGestureRecognizer *gesture))next;

/**
 添加長按手勢，響應時間為0.5f秒
 
 @param delegate 委託
 @param next 長按響應事件
 */
- (void)hsy_addLongGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UILongPressGestureRecognizer *gesture))next;

@end
