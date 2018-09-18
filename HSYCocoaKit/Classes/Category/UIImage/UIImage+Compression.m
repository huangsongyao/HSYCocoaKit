//
//  UIImage+Compression.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/11.
//

#import "UIImage+Compression.h"
#import "UIImage+Canvas.h"

@implementation UIImage (Compression)

- (NSData *)imageCompression:(CGFloat)maxSize
{
    CGFloat compression = 1.0f;
    CGFloat maxCompression = 0.1f;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    while ((data.length > maxSize) && (compression > maxCompression)) {
        compression -= maxCompression;
        data = UIImageJPEGRepresentation(self, compression);
    }
    return data;
}

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
        realImage = [self cutOriginImage:size];
    }
    return realImage;
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


