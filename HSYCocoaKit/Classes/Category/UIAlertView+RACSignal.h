//
//  UIAlertView+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface UIAlertView (RACSignal)

/**
 *  UIAlertView关于RAC的封装范畴_rac格式
 *
 *  @param title             title
 *  @param message           message
 *  @param delegate          delegate
 *  @param cancelButtonTitle cancelButtonTitle
 *  @param otherButtonTitles otherButtonTitles
 *
 *  @return rac信号，点击到button的index
 */
+ (RACSignal *)rac_showAlertViewWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles;
+ (RACSignal *)rac_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray<NSString *> *)otherButtonTitles;

@end
