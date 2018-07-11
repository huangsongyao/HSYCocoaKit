//
//  UIImage+PNG.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/11.
//

#import <UIKit/UIKit.h>

@interface UIImage (PNG)

/**
 JPG转PNG

 @return PNG格式图片
 */
- (UIImage *)toPNG;

/**
 PNG转JPEG

 @return JPEG格式图片
 */
- (UIImage *)toJPEG;

@end
