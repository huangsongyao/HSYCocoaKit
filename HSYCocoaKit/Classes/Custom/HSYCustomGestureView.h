//
//  HSYCustomGestureView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/14.
//

#import <UIKit/UIKit.h>

@class RACSignal;
@interface HSYCustomGestureView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray<NSString *> *hsy_unResponseClases;

/**
 添加单指单击手势到self的视图层

 @return 响应事件
 */
- (RACSignal *)hsy_addSingleGesture;

/**
 添加单指双击手势到self的视图层

 @return 响应事件
 */
- (RACSignal *)hsy_addDoubleGesture;

/**
 默认的用于处理点击手势和其他控件视图自带点击事情冲突，本方法内容的控件类名会被默认忽略

 @return 要忽略的类集合
 */
+ (NSArray<NSString *> *)hsy_defaultUnReponseClasses;

@end
