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

@interface HSYBaseViewController : UIViewController

//可能为nil，如果使用自定义的转场navigationController则该指针不为nil
@property (nonatomic, strong, readonly) HSYCustomNavigationBar *customNavigationBar;    //定制与父类的导航栏
@property (nonatomic, assign) BOOL hsy_addKeyboardObserver;                             //是否添加键盘监听
@property (nonatomic, assign) BOOL hsy_addEndEditedKeyboard;                            //是否添加view层的键盘收起事件
@property (nonatomic, assign) BOOL hsy_addCustomNavigationBarBackButton;                //是否添加返回按钮，默认会根据栈控制器的vc个数来决定（大于1显示），设置为NO后无论栈控制器的vc是否大于1均不显示
@property (nonatomic, strong) HSYBaseRefleshModel *hsy_viewModel;                       //该指针允许指向HSYBaseModel子类中的对象，并且使用了建言模式，不允许为nil，默认为nil，实例化对象请务必在“- viewDidLoad”方法“前”。

/**
 *  请求状态码识别
 *
 *  @param stateCode 状态码
 *
 *  @return 状态码枚举或者error的code码
 */
- (kHSYHUDModelCodeType)hsy_requestStateCodeWithStateCode:(id)stateCode;

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

/**
 hsy_addEndEditedKeyboard设置为YES后，当单机手势关闭键盘后会调用本方法，子类如有需要可重写本方法
 */
- (void)hsy_endEditing;

/**
 适配iOS 11
 */
+ (void)adapterScrollView_iOS_11;

@end
