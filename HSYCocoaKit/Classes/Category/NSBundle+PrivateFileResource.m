//
//  NSBundle+PrivateFileResource.m
//  Pods
//
//  Created by huangsongyao on 2018/4/17.
//
//

#import "NSBundle+PrivateFileResource.h"
#import "HSYBaseViewController.h"

@implementation NSBundle (PrivateFileResource)

+ (UIImage *)imageForBundle:(NSString *)imageName
{
    NSBundle *bundle = [NSBundle bundleForClass:[HSYBaseViewController class]];
    NSString *bundleName = @"HSYCocoaKit";//bundle.infoDictionary[@"CFBundleName"];
    NSURL *bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    if (!bundleURL) {
        return nil;
    }
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    UIImage *image = [UIImage imageNamed:imageName
                                inBundle:resourceBundle
           compatibleWithTraitCollection:nil];
    
    return image;
}


@end
