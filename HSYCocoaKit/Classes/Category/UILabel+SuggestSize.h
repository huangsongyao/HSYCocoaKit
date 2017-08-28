//
//  UILabel+SuggestSize.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (SuggestSize)

+ (UILabel *)initWithText:(NSString *)text numberOfLines:(NSInteger)numberOfLines font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

+ (UILabel *)initWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

+ (UILabel *)initWithUnilineText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

@end
