//
//  UIViewController+Alert.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import <UIKit/UIKit.h>
#import "UIAlertView+RACSignal.h"
#import "UIActionSheet+RACSignal.h"

@interface UIViewController (Alert)

/**
 iOS >= 8.0时创建的是UIAlertController，否则创建UIAlertView，并且alertActionTitles参数中，first请务必填入cancel的title

 @param viewController 所展示的试图控制器
 @param title title
 @param message message
 @param titles 所有按钮的title，first请务必填入cancel的title
 @return RACSignal信号
 */
+ (RACSignal *)hsy_rac_showAlertViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)titles;;

/**
 iOS >= 8.0时创建的是UIAlertController，否则创建UIActionSheet，并且sheetActionTitles的参数中，first请务必填入cancel的title，last请务必填入destructive的title

 @param viewController 所展示的试图控制器
 @param title title
 @param message message
 @param titles 所有按钮的title，并且sheetActionTitles的参数中，first请务必填入cancel的title，last请务必填入destructive的title
 @return RACSignal信号
 */
+ (RACSignal *)hsy_rac_showSheetViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)titles;

/**
 HUD文字提示

 @param message 提示的内容
 */
+ (void)hsy_hudWithMessage:(NSString *)message;

@end
