//
//  UIViewController+Keyboard.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (Keyboard)

/**
 键盘监听，DidChanged
 
 @param object object
 @param next 键盘变更通知，已解析了键值对
 */
- (void)observerToKeyboardDidChanged:(id)object
                       subscribeNext:(void(^)(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local))next;

/**
 键盘监听，DidChanged，只回调frameBegin和frameEnd两个参数
 
 @param object object
 @param completed frameBegin和frameEnd两个回调
 */
- (void)observerToKeyboardDidChanged:(id)object
                  subscribeCompleted:(void(^)(CGRect frameBegin, CGRect frameEnd))completed;

/**
 键盘监听，WillChanged
 
 @param object object
 @param next 键盘变更通知，已解析了键值对
 */
- (void)observerToKeyboardWillChanged:(id)object subscribeNext:(void(^)(CGRect bounds, CGPoint begin, CGPoint end, CGRect frameBegin, CGRect frameEnd, NSNumber *curve, NSNumber *duration, NSNumber *local))next;

/**
 键盘监听，WillChanged，只回调frameBegin和frameEnd两个参数
 
 @param object object
 @param completed frameBegin和frameEnd两个回调
 */
- (void)observerToKeyboardWillChanged:(id)object subscribeCompleted:(void(^)(CGRect frameBegin, CGRect frameEnd))completed;

@end
