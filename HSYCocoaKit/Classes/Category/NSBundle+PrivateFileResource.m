//
//  NSBundle+PrivateFileResource.m
//  Pods
//
//  Created by huangsongyao on 2018/4/17.
//
//

#import "NSBundle+PrivateFileResource.h"

@implementation NSBundle (PrivateFileResource)

+ (UIImage *)imageForBundle:(NSString *)imageName
{
    
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"HSYBaseViewController")];
    NSString *bundleName = bundle.infoDictionary[@"CFBundleName"];
    NSURL *bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    if (!bundleURL) {
        bundleName = @"HSYCocoaKit";
        bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    }
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    UIImage *image = [UIImage imageNamed:imageName
                                inBundle:resourceBundle
           compatibleWithTraitCollection:nil];
    
    return image;
}


@end
