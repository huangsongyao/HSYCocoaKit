//
//  UIActionSheet+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>
#import "ReactiveCocoa.h"

@interface UIActionSheet (RACSignal)

/**
 *  show一个Sheet _rac格式
 *
 *  @param view                   Show In View
 *  @param title                  title
 *  @param delegate               delegate
 *  @param cancelButtonTitle      cancelButtonTitle
 *  @param destructiveButtonTitle destructiveButtonTitle
 *  @param otherButtonTitles      otherButtonTitles
 *
 *  @return rac的signal，即：选中的index
 */
+ (RACSignal *)hsy_rac_showSheetInView:(UIView *)view withTitle:(NSString *)title delegate:(id<UIActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles NS_EXTENSION_UNAVAILABLE_IOS("use - hsy_rac_showSheetController:message:sheetActionTitles");
+ (RACSignal *)hsy_rac_showSheetInView:(UIView *)view withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles NS_EXTENSION_UNAVAILABLE_IOS("use - hsy_rac_showSheetController:message:sheetActionTitles");

@end
