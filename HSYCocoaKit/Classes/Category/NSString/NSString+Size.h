//
//  NSString+Size.h
//  Pods
//
//  Created by huangsongyao on 2017/8/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)

/**
 计算文字显示区域

 @param text 文字内容
 @param font 文字的字号
 @param width 最大显示长度，如果为0，默认最大显示宽度为设备宽度
 @param height 最大显示高度，如果为0，默认最大显示宽度为正向最大值
 @return size
 */
+ (CGSize)contentOfSize:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

/**
 计算文字显示区域

 @param font 文字的字号
 @param width 最大显示长度，如果为0，默认最大显示宽度为设备宽度
 @param height 最大显示高度，如果为0，默认最大显示宽度为正向最大值
 @return size
 */
- (CGSize)contentOfSize:(UIFont *)font maxWidth:(CGFloat)width maxHeight:(CGFloat)height;

/**
 计算文字显示区域,限制最大宽度，计算高度

 @param font font
 @param width 最大显示宽度
 @return size
 */
- (CGSize)contentOfSize:(UIFont *)font maxWidth:(CGFloat)width;

/**
 计算文字显示区域,限制设备高度，计算宽度

 @param font font
 @param height 最大显示高度
 @return size
 */
- (CGSize)contentOfSize:(UIFont *)font maxHeight:(CGFloat)height;

@end
