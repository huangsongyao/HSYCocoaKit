//
//  UIImageView+UrlString.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "UIImageView+UrlString.h"
#import "NSFileManager+Finder.h"
#import "ReactiveCocoa.h"
#import "NSBundle+PrivateFileResource.h"

@implementation UIImageView (UrlString)

- (void)setImageWithUrlString:(NSString *)urlString
{
    UIImage *placeholderImage = [NSBundle imageForBundle:@"image_placeholder"];
    [self setImageWithUrlString:urlString placeholderImage:placeholderImage];
}

- (void)setImageWithUrlString:(NSString *)urlString placeholderImage:(UIImage *)placeholderImage
{
    [self setImageWithUrlString:urlString placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {}];
}

- (void)setImageWithUrlString:(NSString *)urlString
             placeholderImage:(UIImage *)placeholderImage
                    completed:(SDExternalCompletionBlock)completed
{
    if (![urlString hasPrefix:@"http"]) {
        //如果请求链接不是以http开头的远程地址，则尝试拆分，看看链接是否为本地图片资源地址
        NSArray *urls = [urlString componentsSeparatedByString:@"."];
        if (urls.count > 0) {
            NSArray *suffixs = @[
                                 @"png",
                                 @"jpg",
                                 @"gif",
                                 ];
            if ([suffixs containsObject:urls.lastObject]) {
                UIImage *image = [UIImage imageWithContentsOfFile:urlString];
                if (image) {
                    self.image = image;
                    self.highlightedImage = image;
                    return;
                }
            }
        }
    }
    @weakify(self);
    [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @strongify(self);
        [self errorWithError:error withImage:image placeholderImage:placeholderImage];
        if (completed) {
            completed(image, error, cacheType, imageURL);
        }
    }];
}

- (void)errorWithError:(NSError *)error
             withImage:(UIImage *)image
      placeholderImage:(UIImage *)placeholderImage
{
    if (error) {
        NSLog(@"图片请求失败，error = %@, error.code = %ld", error, (long)error.code);
        self.clipsToBounds = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *realPlaceholderImage = placeholderImage;
        if (!realPlaceholderImage) {
            realPlaceholderImage = [NSBundle imageForBundle:@"image_placeholder"];
        }
        switch (error.code) {
                //异常
            case NSURLErrorCannotFindHost :
            case NSURLErrorNotConnectedToInternet :
            case NSURLErrorCannotConnectToHost :
            case NSURLErrorServerCertificateHasBadDate:
            case NSURLErrorCannotDecodeRawData :
            case NSURLErrorCannotDecodeContentData : {
                self.image = realPlaceholderImage;
                self.highlightedImage = realPlaceholderImage;
            }
                break;
                //失败
            case NSURLErrorCancelled :
            case NSURLErrorDownloadDecodingFailedMidStream :
            case NSURLErrorDownloadDecodingFailedToComplete :
            case NSURLErrorTimedOut:
            case 404 : {
                self.image = realPlaceholderImage;
                self.highlightedImage = realPlaceholderImage;
            }
                break;
            default:
                self.image = realPlaceholderImage;
                self.highlightedImage = realPlaceholderImage;
                break;
        }
    } else {
        self.image = image;
        self.highlightedImage = image;
    }
}


@end
