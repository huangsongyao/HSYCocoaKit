//
//  UIImage+Canvas.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIImage+Canvas.h"
#import "UIView+Frame.h"
#import "UIColor+Hex.h"

@implementation UIImage (Canvas)

static UIImage *createImageWithColor(UIColor *color, CGRect rect)
{
    UIGraphicsBeginImageContext(rect.size);//规定一个画布size
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);//画出一个image
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();//获取新的image
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithFillColor:(UIColor *)color
{    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIImage *image = createImageWithColor(color, rect);
    
    return image;
}

+ (UIImage *)imageWithFillColor:(UIColor *)color rect:(CGRect)rect
{
    UIImage *image = createImageWithColor(color, rect);
    return image;
}

+ (UIImage *)captureImageInView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - QRCode

+ (UIImage *)imageWithQRCode:(CGRect)referenceRect
                    cropRect:(CGRect)cropRect
             backgroundColor:(UIColor *)color
{
    CGSize referenceSize = CGSizeMake(CGRectGetWidth(referenceRect), CGRectGetHeight(referenceRect));
    //获取图片颜色的RGB
    UIGraphicsBeginImageContext(referenceSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, color.red, color.green, color.blue, color.alpha);
    //设置RGB和对应的透明度
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect drawRect = CGRectMake(0, 0, screenSize.width,screenSize.height);
    CGContextFillRect(context, drawRect);
    drawRect = CGRectMake(cropRect.origin.x-referenceRect.origin.x, cropRect.origin.y-referenceRect.origin.y, cropRect.size.width, cropRect.size.height);
    CGContextClearRect(context, drawRect);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
