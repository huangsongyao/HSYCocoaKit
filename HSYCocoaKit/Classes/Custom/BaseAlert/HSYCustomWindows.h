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

@interface HSYCustomWindowsComponent : UIView

@property (nonatomic, strong, readonly) UIImageView *hsy_backgroundImageView;           //背景图

@end

@interface HSYCustomWindows : HSYCustomGestureView

@property (nonatomic, strong, readonly) HSYCustomWindowsComponent *hsy_wicketView;      //主体小窗口的视图层
@property (nonatomic, assign) CGFloat hsy_blackMaskMaxAlpha;                            //黑色遮罩的最大透明度
@property (nonatomic, assign, setter=wicketViewCGRect:) CGRect hsy_wicketCGRect;        //添加接口，允许外部重置主体小窗口的frame，本属性只对锚点(0.5, 0.5)的位置的默认小窗口有效
@property (nonatomic, assign, setter=wicketViewCornerRadius:) CGFloat hsy_wicketRadius; //添加接口，允许外部重置主体小窗口的layer.cornerRadius圆角，本属性只对锚点(0.5, 0.5)的位置的默认小窗口有效

/**
 初始化，默认主体小弹窗为锚点(0.5, 0.5)的位置，默认主体小窗口的背景图片为白色，本方法会“立即释放”键盘监听或者单击remove手势的冷信号

 @param remove 点击空白部分的单击手势的回调事件
 @return HSYCustomWindows
 */
- (instancetype)initWithDefaults:(void(^)(HSYCustomWindows *view))remove;

/**
 初始化，默认主体小弹窗为锚点(0.5, 0.5)的位置，默认主体小窗口的背景图片为白色，本方法会“立即释放”键盘监听或者单击remove手势的冷信号，不添加键盘监听事件

 @param remove 点击空白部分的单击手势的回调事件
 @return HSYCustomWindows
 */
- (instancetype)initWithUnobserverDefaults:(void(^)(HSYCustomWindows *view))remove;

/**
 初始化，默认主体小弹窗为锚点(0.5, 0.5)的位置，默认主体小窗口的背景图片为白色，本方法“不释放”键盘监听或者单击remove手势的冷信号，并且不添加键盘监听事件

 @param remove 点击空白部分的单击手势的回调事件
 @return HSYCustomWindows
 */
- (instancetype)initWithUnimmediatelyUnobserverDefaults:(void(^)(HSYCustomWindows *view))remove;

/**
 初始化，默认主体小弹窗为锚点(0.5, 0.5)的位置，默认主体小窗口的背景图片为白色，本方法“不释放”键盘监听或者单击remove手势的冷信号

 @param remove 点击空白部分的单击手势的回调事件
 @return HSYCustomWindows
 */
- (instancetype)initWithUnimmediatelyDefaults:(void(^)(HSYCustomWindows *view))remove;

/**
 初始化，本方法会“立即释放”键盘监听或者单击remove手势的冷信号

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
 初始化，本方法会“不释放”键盘监听或者单击remove手势的冷信号
 
 @param anchorPoint 锚点
 @param position 锚点下的坐标位置
 @param backgroundImage 主体小窗口的背景图片
 @param remove 点击空白部分的单击手势的回调事件
 @return HSYCustomWindows
 */
- (instancetype)initWithUnimmediatelyDefaults:(CGPoint)anchorPoint
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

