//
//  HSYCustomGestureView.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/14.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSInteger const kHSYCocoaKitSingleGestureDefaultTags;

@class RACSignal;
@interface HSYCustomGestureView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) NSArray<NSString *> *hsy_unResponseClases;

/**
 键盘监听，是否立即释放监听冷信号由completedSignal决定

 @param completedSignal 是否立即释放监听冷信号
 @return RACSignal
 */
- (RACSignal *)hsy_keyboardObserver:(BOOL)completedSignal;

/**
 添加单指单击手势到self的视图层，点击后会立即释放冷信号

 @return 响应事件
 */
- (RACSignal *)hsy_addSingleGesture;

/**
 添加单指单击手势到self的视图层，点击后会是否释放冷信号由completedSignal决定

 @param completedSignal 是否释放冷信号
 @return RACSignal
 */
- (RACSignal *)hsy_addSingleGesture:(BOOL)completedSignal;

/**
 添加单指双击手势到self的视图层，点击后会立即释放冷信号

 @return 响应事件
 */
- (RACSignal *)hsy_addDoubleGesture;

/**
 添加单指双击手势到self的视图层，点击后会是否释放冷信号由completedSignal决定

 @param completedSignal 是否释放冷信号
 @return RACSignal
 */
- (RACSignal *)hsy_addDoubleGesture:(BOOL)completedSignal;

/**
 默认的用于处理点击手势和其他控件视图自带点击事情冲突，本方法内容的控件类名会被默认忽略

 @return 要忽略的类集合
 */
+ (NSArray<NSString *> *)hsy_defaultUnReponseClasses;

@end

@interface HSYCustomSingleGestureMaskView : HSYCustomGestureView

/**
 初始化一个支持单击手势视图，视图的size为window层的size，backgroundColor为透明色

 @param gesture 手势回调的block
 @return HSYCustomSingleGestureMaskView
 */
- (instancetype)initWithSingleGesture:(void(^)(UITapGestureRecognizer *ges, HSYCustomSingleGestureMaskView *view))gesture;

@end

