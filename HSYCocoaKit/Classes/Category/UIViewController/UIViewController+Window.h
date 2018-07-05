//
//  UIViewController+Window.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/5.
//

#import <UIKit/UIKit.h>
#import "HSYCustomGestureView.h"

@interface UIViewController (Window)

/**
 动态添加一个透明层在键盘层和self.view中间，用于回收键盘，同时提供了“object”和“键盘监听”回调和“单击回收”回调

 @param object object
 @param keyboard “键盘监听”block
 @param next “单击回收”block
 */
- (void)hsy_keyboardGestureRecycle:(id)object
                  observerKeyboard:(void(^)(BOOL isRecycle))keyboard
                     subscribeNext:(RACSignal *(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next;

/**
 动态添加一个透明层在键盘层和self.view中间，用于回收键盘，同时提供了“键盘监听”回调和“单击回收”回调

 @param keyboard “键盘监听”block
 @param next “单击回收”block
 */
- (void)hsy_keyboardGestureRecycle:(void(^)(BOOL isRecycle))keyboard
                     subscribeNext:(RACSignal *(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next;

/**
 动态添加一个透明层在键盘层和self.view中间，用于回收键盘，同时提供了“object”回调和“键盘监听”回调

 @param object object
 @param keyboard “键盘监听”block
 */
- (void)hsy_keyboardGestureRecycle:(id)object
                  observerKeyboard:(void(^)(BOOL isRecycle))keyboard;

/**
 动态添加一个透明层在键盘层和self.view中间，用于回收键盘，同时提供了“object”回调和“单击回收”回调

 @param object object
 @param next “单击回收”
 */
- (void)hsy_keyboardGestureRecycleObject:(id)object
                           subscribeNext:(RACSignal *(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next;

/**
 动态添加一个透明层在键盘层和self.view中间，用于回收键盘，只提供了和“单击回收”回调

 @param next “单击回收”block
 */
- (void)hsy_keyboardGestureRecycle:(RACSignal *(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next;

/**
 动态添加一个透明层在键盘层和self.view中间，用于回收键盘，只提供了和“键盘监听”回调
 
 @param keyboard “键盘监听”block
 */
- (void)hsy_keyboardGestureRecycleKeyboard:(void(^)(BOOL isRecycle))keyboard;

@end
