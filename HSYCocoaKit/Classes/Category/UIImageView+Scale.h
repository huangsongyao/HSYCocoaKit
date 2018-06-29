//
//  UIImageView+Scale.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/5/29.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Scale)

/**
 根据要显示在屏幕上的宽度displayWidth和图片image的原始size，动态放缩要显示在屏幕上的图片的height

 @param displayWidth 要固定显示在屏幕上的宽度
 @param image image图片
 @return 动态放缩要显示在屏幕上的图片的height
 */
+ (CGFloat)hsy_scaleHeight:(CGFloat)displayWidth image:(UIImage *)image;

/**
 根据要显示在屏幕上的宽度displayHeight和图片image的原始size，动态放缩要显示在屏幕上的图片的width
 
 @param displayHeight 要固定显示在屏幕上的高度
 @param image image图片
 @return 动态放缩要显示在屏幕上的图片的width
 */
+ (CGFloat)hsy_scaleWidth:(CGFloat)displayHeight image:(UIImage *)image;

/**
 根据图片原始size对图片进行放缩，放缩方式为:通过比较原始图片的size决定放缩依据为设备的高度或者宽度

 @param imageSize 要放缩的图片的原始size
 @return 根据原始size和手机设备宽高所放缩后的图片大小的new size
 */
+ (CGSize)hsy_scaleCGSize:(CGSize)imageSize;

/**
 根据self.image的原始size放缩图片，规则为方法“+ hsy_scaleCGSize:”中的规则

 @return 放缩后的图片size
 */
- (CGSize)scaleCGSize;

/**
 根据图片原始size对图片进行放缩，放缩方式为“- scaleCGSize”方法，并同时对图片在window层为背景的居中处理
 */
- (void)scaleCentryCGRect;

@end
