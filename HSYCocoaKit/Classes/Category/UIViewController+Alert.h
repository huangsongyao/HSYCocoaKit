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

 @param title title
 @param message message
 @param titles 所有按钮的title，first请务必填入cancel的title
 @return RACSignal信号
 */
+ (RACSignal *)hsy_rac_showAlertView:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)titles;

/**
 iOS >= 8.0时创建的是UIAlertController，否则创建UIActionSheet，并且sheetActionTitles的参数中，first请务必填入cancel的title，last请务必填入destructive的title

 @param title title
 @param message message
 @param titles 所有按钮的title，并且sheetActionTitles的参数中，first请务必填入cancel的title，last请务必填入destructive的title
 @return RACSignal信号
 */
+ (RACSignal *)hsy_rac_showSheetView:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)titles;

@end
