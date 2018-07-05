//
//  UIView+Gestures.h
//  Pods
//
//  Created by huangsongyao on 2018/5/7.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Gestures)

#pragma mark - Tap

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

#pragma mark - Longs

/**
 添加長按手勢
 
 @param delegate 委託
 @param duration 响应时间
 @param next 長按響應事件
 */
- (void)hsy_addLongGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate minimumPressDuration:(CFTimeInterval)duration subscribeNext:(void(^)(UILongPressGestureRecognizer *gesture))next;

#pragma mark - Swipe

/**
 添加单方向滑动手势

 @param delegate 委托
 @param direction 滑动方向枚举
 @param next 滑动响应事件
 */
- (void)hsy_addSwipeGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate recognizerDirection:(UISwipeGestureRecognizerDirection)direction subscribeNext:(void(^)(UISwipeGestureRecognizer *gesture))next;

/**
 添加多个方向的滑动手势

 @param delegate 委托
 @param directions 方向枚举集合
 @param next 滑动响应事件
 */
- (void)hsy_addSwipeGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate recognizerDirections:(NSArray<NSNumber *> *)directions subscribeNext:(void(^)(UISwipeGestureRecognizer *gesture, UISwipeGestureRecognizerDirection direction))next;

#pragma mark - Pan

/**
 添加上下左右四个方向的滑动手势

 @param delegate 委托
 @param next 滑动响应事件
 */
- (void)hsy_addPanGestureRecognizerDelegate:(id<UIGestureRecognizerDelegate>)delegate subscribeNext:(void(^)(UIPanGestureRecognizer *gesture))next;

@end
