//
//  NSBundle+PrivateFileResource.h
//  Pods
//
//  Created by huangsongyao on 2018/4/17.
//
//

#import <Foundation/Foundation.h>

@interface NSBundle (PrivateFileResource)

/**
 专门加载私有库资源图片文件

 @param imageName 图片文件名称
 @return 图片转化为的UIImage对象
 */
+ (UIImage *)imageForBundle:(NSString *)imageName;

/**
 根据CFBundleName作为可以寻址，如果无法找到对应的NSBundle，则返回HSYCocoaKit的NSBundle

 @return NSBundle
 */
+ (NSBundle *)resourceBundle;

@end
