//
//  UIImageView+UrlString.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@interface UIImageView (UrlString)

/**
 sd请求图片远端地址，无回调，默认占位图为：image_placeholder

 @param urlString 图片远端地址
 */
- (void)setImageWithUrlString:(NSString *)urlString;

/**
 sd请求图片远端地址，无回调

 @param urlString 图片远端地址
 @param placeholderImage 默认占位图
 */
- (void)setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;

/**
 sd请求图片远端地址

 @param urlString 图片远端地址
 @param placeholderImage 默认占位图
 @param completed 结果回调
 */
- (void)setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completed;

@end
