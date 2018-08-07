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
+ (UIImage *)imageWithQRCode:(CGRect)referenceRect cropRect:(CGRect)cropRect backgroundColor:(UIColor *)color;

/**
 CIImage转UIImage，同时内部转换

 @param size 绘制的UIImage的原始size
 @param ciImage CIImage
 @return 绘制新的UIImage
 */
+ (UIImage *)imageWithQrCodeSize:(CGFloat)size withCIImage:(CIImage *)ciImage NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 在原图的基础上裁剪一张指定尺寸的新图，保证图片不会因为压缩而变形，超出部分则使用透明填充色

 @param size 新图片的尺寸
 @return 指定尺寸的新图
 */
- (UIImage *)cutOriginImage:(CGSize)size NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 根据给定的背景色，绘制一张作为背景的图片，并将这张背景图和本身图片重叠组成新的带背景图的图片

 @param backgroundColor 背景的图片的颜色
 @return 重叠组成新的带背景图的图片
 */
- (UIImage *)combinationOriginImage:(UIColor *)backgroundColor NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
