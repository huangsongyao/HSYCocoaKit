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

#pragma mark - Draw

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

+ (UIImage *)imageWithQRCode:(CGRect)referenceRect cropRect:(CGRect)cropRect backgroundColor:(UIColor *)color
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

+ (UIImage *)imageWithQrCodeSize:(CGFloat)size withCIImage:(CIImage *)ciImage
{
    CGRect extent = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceGray();
    
    //指向要渲染的绘制内存的地址。这个内存块的大小至少是（bytesPerRow*height）个字节
    //bitmap的宽度,单位为像素
    //bitmap的高度,单位为像素
    //内存中像素的每个组件的位数.例如，对于32位像素格式和RGB 颜色空间，你应该将这个值设为8.
    //bitmap的每一行在内存所占的比特数
    //bitmap上下文使用的颜色空间
    //指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, spaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *content = [CIContext contextWithOptions:nil];
    CGImageRef bitmapRef = [content createCGImage:ciImage fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, bitmapRef);
    
    CGImageRef resultImageRef = CGBitmapContextCreateImage(contextRef);
    CGContextRelease(contextRef);
    CGImageRelease(bitmapRef);
    
    UIImage *image = [UIImage imageWithCGImage:resultImageRef];
    return image;
}

#pragma mark - Cut

- (UIImage *)cutOriginImage:(CGSize)size
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointZero;
    
    if (!CGSizeEqualToSize(self.size, size)) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
}

@end
