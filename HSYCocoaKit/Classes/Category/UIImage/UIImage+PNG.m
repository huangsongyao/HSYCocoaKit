//
//  UIImage+PNG.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/7/11.
//

#import "UIImage+PNG.h"

@implementation UIImage (PNG)

- (UIImage *)toPNG
{
    NSData *data = UIImagePNGRepresentation(self);
    UIImage *imagePNG = [UIImage imageWithData:data];
    return imagePNG;
}

- (UIImage *)toJPEG
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0f);
    UIImage *imageJPEG = [UIImage imageWithData:data];
    return imageJPEG;
}

@end
