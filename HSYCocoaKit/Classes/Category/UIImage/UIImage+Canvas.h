//
//  UIImage+Canvas.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>
#import "PublicMacroFile.h"

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

/**
 绘制一张二维码使用的图片

 @param referenceRect 要添加的父视图的frame
 @param cropRect 中部挖空的frame
 @param color 图的颜色
 @return UIImage
 */
+ (UIImage *)imageWithQRCode:(CGRect)referenceRect
                    cropRect:(CGRect)cropRect
             backgroundColor:(UIColor *)color;

/**
 CIImage转UIImage，同时内部转换

 @param size 绘制的UIImage的原始size
 @param ciImage CIImage
 @return 绘制新的UIImage
 */
+ (UIImage *)imageWithQrCodeSize:(CGFloat)size withCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
