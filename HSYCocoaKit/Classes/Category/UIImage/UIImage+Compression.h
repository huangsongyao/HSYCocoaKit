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

@end
