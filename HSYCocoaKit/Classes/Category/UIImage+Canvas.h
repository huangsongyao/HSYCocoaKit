//
//  UIImage+Canvas.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Canvas)

/**
 创建不定区域的图片

 @param color 图片颜色
 @return UIImage
 */
+ (UIImage *)imageWithFillColor:(UIColor *)color;

/**
 创建rect区域的图片

 @param color 图片颜色
 @param rect 图片区域
 @return UIImage
 */
+ (UIImage *)imageWithFillColor:(UIColor *)color rect:(CGRect)rect;

/**
 将视图剪裁成一张图片

 @param view 视图对象
 @return UIView -> UIImage
 */
+ (UIImage *)captureImageInView:(UIView *)view;

@end
