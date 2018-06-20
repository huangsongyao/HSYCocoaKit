//
//  HSYCustomWindows.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/20.
//

#import "HSYCustomGestureView.h"
#import "ReactiveCocoa.h"

static CGFloat kHSYCocoaKitMaxScale                 = 1.0f;
static CGFloat kHSYCocoaKitMinScale                 = 0.0f;

#define HSYCOCOAKIT_GGA_TRANSFORM_SCALE(scale)      (CGAffineTransformScale(CGAffineTransformIdentity, scale, scale))

@interface HSYCustomWindowsComponent : UIView

@property (nonatomic, strong, readonly) UIImageView *hsy_backgroundImageView;

@end

@interface HSYCustomWindows : HSYCustomGestureView

@property (nonatomic, strong, readonly) HSYCustomWindowsComponent *hsy_wicketView;    //主体小窗口的视图层
- (instancetype)initWithDefaults:(void(^)(HSYCustomWindows *view))remove;

/**
 show的动画过度基础方法，父类中已经对黑色遮罩做了过度动画处理，子类中请调用本方法，并在next和completed中实现其他动画逻辑

 @return RACSignal，next和completed触发动画逻辑
 */
- (RACSignal *)hsy_rac_showAlert;

/**
 remove的动画过度基础方法，父类中已经对黑色遮罩做了过度动画处理，子类中请调用本方法，并在next和completed中实现其他动画逻辑，completion block会在completed执行后再执行

 @return RACSignal，next和completed触发动画逻辑
 */


/**
 remove的动画过度基础方法，父类中已经对黑色遮罩做了过度动画处理，子类中请调用本方法，并在next和completed中实现其他动画逻辑，completion block会在completed执行后再执行，并且是否立即执行remove根据isAtOnceRemove决定

 @param isAtOnceRemove 是否在动画的completion block执行中立即执行remove操作
 @return RACSignal，next和completed触发动画逻辑
 */
- (RACSignal *)hsy_rac_removeAlert:(BOOL)isAtOnceRemove;

/**
 动画时间，如需定制时间，子类请重写本方法

 @return 动画时间
 */
- (NSTimeInterval)hsy_durations;

@end

