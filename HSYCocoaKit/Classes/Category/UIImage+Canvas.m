//
//  UIImage+Canvas.m
//  Pods
//
//  Created by huangsongyao on 2017/3/28.
//
//

#import "UIImage+Canvas.h"
#import "UIView+Frame.h"

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

+ (UIImage *)createImgWithColor:(UIColor *)color
{    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIImage *image = createImageWithColor(color, rect);
    
    return image;
}

+ (UIImage *)createImgWithColor:(UIColor *)color rect:(CGRect)rect
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


@end
