//
//  HSYCustomWindows.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/6/20.
//

#import "HSYCustomGestureView.h"
#import "ReactiveCocoa.h"
#import "PublicMacroFile.h"

static CGFloat kHSYCocoaKitMaxScale                 = 1.0f;
static CGFloat kHSYCocoaKitMinScale                 = 0.0f;

#define HSYCOCOAKIT_GGA_TRANSFORM_SCALE(scale)      (CGAffineTransformScale(CGAffineTransformIdentity, scale, scale))

@interface HSYCustomWindowsComponent : UIView

@end

@interface HSYCustomWindows : HSYCustomGestureView

@property (nonatomic, strong, readonly) HSYCustomWindowsComponent *hsy_wicketView;    //主体小窗口的视图层

/**
 初始化，默认主体小弹窗为锚点(0.5, 0.5)的位置，默认主体小窗口的背景图片为白色

 @param remove 点击空白部分的单击手势的回调事件
 @return HSYCustomWindows
 */
- (instancetype)initWithDefaults:(void(^)(HSYCustomWindows *view))remove;

/**
 初始化

 @param anchorPoint 锚点
 @param position 锚点下的坐标位置
 @param backgroundImage 主体小窗口的背景图片
 @param remove 点击空白部分的单击手势的回调事件
 @return HSYCustomWindows
 */
- (instancetype)initWithDefaults:(CGPoint)anchorPoint
                        position:(CGPoint)position
                 backgroundImage:(UIImage *)backgroundImage
                          remove:(void(^)(HSYCustomWindows *view))remove;

/**
 show方法，父类中已对半透明遮罩做渐变过度动画，子类请调用本方法，并在show和completed中写入后续动画内容

 @param show show的回调
 @param completed completed的回调
 */
- (void)hsy_rac_showAlert:(void(^)(UIView *view))show completed:(void(^)(BOOL finished, UIView *view))completed;

/**
 remove方法，父类中已对半透明遮罩做渐变过度动画，子类请调用本方法，并在show和completed中写入后续动画内容

 @param remove remove的回调
 @param completed completed的回调
 */
- (void)hsy_rac_removeAlert:(void(^)(UIView *view))remove completed:(RACSignal *(^)(BOOL finished, UIView *view))completed;

/**
 动画时间，如需定制时间，子类请重写本方法

 @return 动画时间
 */
- (NSTimeInterval)hsy_durations;


@end

