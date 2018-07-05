//
//  HSYBaseViewController.h
//  Pods
//
//  Created by huangsongyao on 2017/3/29.
//
//

#import <UIKit/UIKit.h>
#import "HSYHUDModel.h"
#import "HSYBaseRefleshModel.h"
#import "UIViewController+Keyboard.h"
#import "HSYCustomNavigationBar.h"
#import "HSYBaseCustomNavigationController.h"

@interface HSYBaseViewController : UIViewController <UIGestureRecognizerDelegate>

//可能为nil，如果使用自定义的转场navigationController则该指针不为nil
@property (nonatomic, strong, readonly) UIView *customNavigationBar;                    //定制与父类的导航栏，iOS 11前本指针指向HSYCustomNavigationBar类，iOS 11后指向HSYCustomNavigationContentViewBar类

#pragma mark - 以下属性请在“[super viewDidLoad]”方法调用前设置

@property (nonatomic, copy) NSString *backItemImage;                                    //返回按钮的图标，默认使用@"nav_icon_back"
@property (nonatomic, assign) BOOL hsy_addKeyboardObserver;                             //是否添加键盘监听
@property (nonatomic, assign) BOOL hsy_addEndEditedKeyboard;                            //是否添加view层的键盘收起事件
@property (nonatomic, strong) id hsy_keyboardObserObject;                               //当“hsy_addKeyboardObserver”为YES时，允许设置本属性，用于keyboard监听的id类型的Object传参
@property (nonatomic, assign) BOOL hsy_addCustomNavigationBarBackButton;                //是否添加返回按钮，默认会根据栈控制器的vc个数来决定（大于1显示），设置为NO后无论栈控制器的vc是否大于1均不显示
@property (nonatomic, strong) HSYBaseRefleshModel *hsy_viewModel;                       //该指针允许指向HSYBaseModel子类中的对象，并且使用了建言模式，不允许为nil，默认为nil，实例化对象请务必在“- viewDidLoad”方法“前”。

#pragma mark - 以下属性无硬性使用规则

@property (nonatomic, assign, setter=showSystemLoading:) BOOL hsy_showLoading;          //是否在进入新vc控制器后，显示系统默认的loading，默认为否，并且由于情况种类太多，如果该属性设置为YES，请在需要的时候调用“- hsy_endSystemLoading”方法停止loading动画，父类中不对该loading逻辑做跟进和处理
@property (nonatomic, assign) UIStatusBarStyle statusBarStyle;                          //状态栏的字体颜色，默认为UIStatusBarStyleDefault[黑色字体]
@property (nonatomic, strong) NSMutableArray<NSString *> *hsy_clashGestures;            //用于处理手势冲突的情况，本数组请填入不支持手势操作交互的类名

#pragma mark - Network State Code

/**
 *  请求状态码识别
 *
 *  @param stateCode 状态码
 *
 *  @return 状态码枚举或者error的code码
 */
- (kHSYHUDModelCodeType)hsy_requestStateCodeWithStateCode:(id)stateCode;

#pragma mark - Custom NavigationBar

/**
 提供接口方法允许子类重新设置返回按钮，模式为：文字模式
 
 @param left left为YES表示按钮在左侧，否则表示按钮在右侧
 @param title 按钮的title
 */
- (void)hsy_setCustomNavigationBarBackButtonInLeft:(BOOL)left title:(NSString *)title;

/**
 提供接口方法允许子类重新设置返回按钮，模式为：图片模式
 
 @param left left为YES表示按钮在左侧，否则表示按钮在右侧
 @param image 按钮的图片名称
 */
- (void)hsy_setCustomNavigationBarBackButtonInLeft:(BOOL)left image:(NSString *)image;

/**
 隐藏定制的导航栏
 */
- (void)hiddenCustomNavigationBar;

/**
 允许子类手动添加定制的导航栏
 */
- (void)hsy_addCustomNavigationBar;

#pragma mark - Keyboard

/**
 hsy_addEndEditedKeyboard设置为YES后，当单机手势关闭键盘后会调用本方法，子类如有需要可重写本方法
 */
- (void)hsy_endEditing;

#pragma mark - iOS 11

/**
 适配iOS 11
 */
+ (void)adapterScrollView_iOS_11;

/**
 返回真正的导航栏的UINavigationItem，兼容iOS 11
 
 @return UINavigationItem
 */
- (UINavigationItem *)hsy_customNavigationBarNavigationItem;

#pragma mark - Loading

/**
 停止系统默认的loading，只有hsy_showLoading为YES时，本方法才有效
 */
- (void)hsy_endSystemLoading;

#pragma mark - Set Custom NavigationBar BackgroundImage

/**
 提供接口方法，允许外部和子类设置定制导航栏的背景图片，方法内已兼容iOS 11
 
 @param backgroundImage 背景图片
 */
- (void)hsy_setCustomNavigationBarBackgroundImage:(UIImage *)backgroundImage;

#pragma mark - Real Custom NavigationBar

/**
 返回适配当前系统下【主要适配iOS 11和iOS 11以下的CustomNavigationBar】NavigationBar对象
 
 @return HSYCustomNavigationBar
 */
- (HSYCustomNavigationBar *)hsy_realCustomNativigation;

@end
