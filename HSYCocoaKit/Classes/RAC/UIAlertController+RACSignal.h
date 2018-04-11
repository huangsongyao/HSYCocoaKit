//
//  UIAlertController+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface UIAlertController (RACSignal)

/**
 alert show

 @param title title
 @param message message
 @param alertActionTitles alertAction的title的list
 @return RACSignal点击事件的信号
 */
+ (RACSignal *)hsy_rac_showAlertController:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)alertActionTitles NS_AVAILABLE_IOS(8_0);

/**
 sheet show

 @param title title
 @param message message
 @param sheetActionTitles alertAction的title的list
 @return RACSignal点击事件的信号
 */
+ (RACSignal *)hsy_rac_showSheetController:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles NS_AVAILABLE_IOS(8_0);

@end
