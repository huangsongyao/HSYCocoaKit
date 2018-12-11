//
//  UIImage+Finder.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/12/11.
//

#import "UIImage+Finder.h"
#import "NSFileManager+Finder.h"

@implementation UIImage (Finder)

+ (UIImage *)hsy_finderImageFromName:(NSString *)name forType:(NSString *)type
{
    NSString *path = [NSFileManager finderFileFromName:name fileType:type];
    UIImage *image = [UIImage hsy_finderImageInSandbox:[NSURL fileURLWithPath:path]];
    
    return image;
}

+ (UIImage *)hsy_finderImageInSandbox:(NSURL *)fileUrl
{
    NSData *imageData = [NSData dataWithContentsOfURL:fileUrl];
    UIImage *image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
