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
+ (RACSignal *)rac_showAlertController:(NSString *)title message:(NSString *)message alertActionTitles:(NSArray<NSString *> *)alertActionTitles;

/**
 sheet show

 @param title title
 @param message message
 @param sheetActionTitles alertAction的title的list
 @return RACSignal点击事件的信号
 */
+ (RACSignal *)rac_showSheetController:(NSString *)title message:(NSString *)message sheetActionTitles:(NSArray<NSString *> *)sheetActionTitles;

@end
