//
//  UIImage+Compression.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/11.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compression)

/**
 压缩图片尺寸

 @param size 要压缩成的尺寸
 @return 压缩后的新图片
 */
- (UIImage *)imageCompressionSize:(CGSize)size;

/**
 压缩图片质量

 @param scale 要压缩成的质量，取值范围为：[0, 1]闭区间
 @return 压缩后的新图片
 */
- (UIImage *)imageCompressionScale:(CGFloat)scale;

/**
 压缩图片质量，利用while循环，根据给定最大图片质量值maxSize，循环压缩，直至图片的data.length长度小于等于maxSize
 
 @param maxSize 给定最大图片质量值
 @return 压缩后的图片
 */
- (NSData *)imageCompression:(CGFloat)maxSize;


@end
