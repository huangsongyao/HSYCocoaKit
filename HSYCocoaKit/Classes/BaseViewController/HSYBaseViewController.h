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
@property (nonatomic, strong, readonly) HSYCustomNavigationBar *customNavigationBar;
@property (nonatomic, assign) BOOL hsy_addKeyboardObserver;        //是否添加键盘监听
@property (nonatomic, strong) HSYBaseRefleshModel *hsy_viewModel;  //该指针允许指向HSYBaseModel子类中的对象，并且使用了建言模式，不允许为nil，默认为nil，实例化对象请务必在“- viewDidLoad”方法“前”。

/**
 *  请求状态码识别
 *
 *  @param stateCode 状态码
 *
 *  @return 状态码枚举或者error的code码
 */
- (kHSYHUDModelCodeType)hsy_requestStateCodeWithStateCode:(id)stateCode;

@end
