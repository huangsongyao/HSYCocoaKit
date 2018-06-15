//
//  UINavigationBar+Background.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Background)

/**
 设置navigationBar的背景图

 @param backgroundImage 背景图
 */
- (void)setNavigationBarBackgroundImage:(UIImage *)backgroundImage;

/**
 清除navigationBar默认的地步的横线
 */
- (void)clearNavigationBarBottomLine;

/**
 设置navigaitonBar底部的横线的颜色

 @param color 横线的颜色
 @param tag 绑定横线的tag
 */
- (void)setBarBottomLineOfColor:(UIColor *)color tag:(NSInteger)tag;

@end
