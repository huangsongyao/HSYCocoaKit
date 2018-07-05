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
 添加透明控制层，以支持单击手势回收键盘，处理方式为：当键盘弹起时，动态创建一张透明视图，遮挡住self.view，同时在该视图上添加响应手势以回收键盘
 
 @param object object
 @param next 单击手势响应block
 */
- (void)hsy_keyboardGestureRecycle:(id)object subscribeNext:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next;

/**
 添加透明控制层，以支持单击手势回收键盘，处理方式为：当键盘弹起时，动态创建一张透明视图，遮挡住self.view，同时在该视图上添加响应手势以回收键盘
 
 @param object object
 @param next 单击手势响应block，会返回是否为回收键盘的状态
 */
- (void)hsy_keyboardGestureRecycles:(id)object subscribeNext:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view, BOOL isRecycle))next;

/**
 添加透明控制层，以支持单击手势回收键盘，处理方式为：当键盘弹起时，动态创建一张透明视图，遮挡住self.view，同时在该视图上添加响应手势以回收键盘
 
 @param next 单击手势响应block
 */
- (void)hsy_keyboardGestureRecycle:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))next;

/**
 添加透明控制层，以支持单击手势回收键盘，处理方式为：当键盘弹起时，动态创建一张透明视图，遮挡住self.view，同时在该视图上添加响应手势以回收键盘
 
 @param next 单击手势响应block，会返回是否为回收键盘的状态
 */
- (void)hsy_keyboardGestureRecycles:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view, BOOL isRecycle))next;

@end
