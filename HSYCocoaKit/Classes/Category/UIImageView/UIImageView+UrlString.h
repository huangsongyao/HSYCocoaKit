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

- (void)setImageWithUrlString:(NSString *)urlString;
- (void)setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage;
- (void)setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage completed:(SDExternalCompletionBlock)completed;

@end
