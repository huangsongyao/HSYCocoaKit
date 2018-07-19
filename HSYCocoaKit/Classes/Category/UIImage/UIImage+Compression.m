//
//  UIImage+Compression.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/11.
//

#import "UIImage+Compression.h"

@implementation UIImage (Compression)

- (UIImage *)imageCompressionScale:(CGFloat)scale compressionSize:(CGSize)size
{
    UIImage *realImage = nil;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        //压缩图片质量
        CGFloat realScale = scale;
        if (realScale < 0.0f) {
            realScale = 0.0f;
        } else if (scale > 1.0f) {
            scale = 1.0f;
        }
        NSData *data = UIImageJPEGRepresentation(self, realScale);
        realImage = [UIImage imageWithData:data];
    } else {
        //压缩图片尺寸
        UIGraphicsBeginImageContext(size);
        [self drawInRect:(CGRect){0.0f, 0.0f, size}];
        realImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return realImage;
}

- (NSData *)imageCompression:(CGFloat)maxSize
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    if (data.length > maxSize) {
        CGFloat bytes = (data.length / 1024.0f);
        CGFloat maxQuality = 0.99f;
        CGFloat lastData = bytes;
        while ((bytes > maxSize && maxQuality > 0.01f)) {
            maxQuality -= 0.01f;
            data = UIImageJPEGRepresentation(self, maxQuality);
            bytes = (data.length / 1024.0f);
            if (lastData <= bytes) {
                break;
            } else {
                lastData = bytes;
            }
        }
    }
    return data;
}

- (UIImage *)imageCompressionSize:(CGSize)size
{
    return [self imageCompressionScale:0.0f compressionSize:size];
}

- (UIImage *)imageCompressionScale:(CGFloat)scale
{
    return [self imageCompressionScale:scale compressionSize:CGSizeZero];
}


@end


