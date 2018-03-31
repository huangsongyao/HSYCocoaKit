//
//  UILabel+SuggestSize.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import <UIKit/UIKit.h>

@interface UILabel (SuggestSize)

/**
 创建自动算高的标签，当numberOfLines == 1时，行高为单行高度

 @param text 内容
 @param numberOfLines 行数
 @param font 字号
 @param width 最大显示宽度，如果为0，默认为设备宽度
 @param height 最大显示高度，默认最大高度
 @return UILabel
 */
+ (UILabel *)initWithText:(NSString *)text numberOfLines:(NSInteger)numberOfLines font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

/**
 创建自动算高的标签，行数为最大显示行数，即：numberOfLines == 0

 @param text 内容
 @param font 字号
 @param width 最大显示宽度，如果为0，默认为设备宽度
 @param height 最大显示高度，默认最大高度
 @return UILabel
 */
+ (UILabel *)initWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

/**
 创建自动算高的标签，行数为1

 @param text 内容
 @param font 字号
 @param width 最大显示宽度，如果为0，默认为设备宽度
 @param height 最大显示高度，默认最大高度
 @return UILabel
 */
+ (UILabel *)initWithUnilineText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

@end
