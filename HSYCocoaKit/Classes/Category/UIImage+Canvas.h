//
//  UIImage+Canvas.h
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Canvas)

+ (UIImage *)createImgWithColor:(UIColor *)color;
+ (UIImage *)createImgWithColor:(UIColor *)color rect:(CGRect)rect;
+ (UIImage *)captureImageInView:(UIView *)view;

@end
