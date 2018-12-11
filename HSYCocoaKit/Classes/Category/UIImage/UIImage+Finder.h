//
//  UIImage+Finder.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/12/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Finder)

/**
 根据文件的名称的后缀类型，到本地资源文件和沙盒中寻找该文件的路径，沙盒路径寻找对象为doucment、cache和library，如果存在则返回该资源的本地路径或本地沙盒路径，由于搜索内容涵盖doucment、cache和library，最好不要再主线程上使用该方法做太多的耗时操作，以免出现卡顿，最后返回图片或者nil

 @param name 图片名称
 @param type 图片后缀类型
 @return UIImage
 */
+ (UIImage *)hsy_finderImageFromName:(NSString *)name forType:(NSString *)type;

/**
 在沙盒中寻找图片

 @param fileUrl 图片的沙盒缓存路径，完整的路径，如：(NSURL)=@"file:///Users/huangsongyao/library/Developer/CorSimulator/Devices/.../Documents/xxx.png"
 @return UIImage
 */
+ (UIImage *)hsy_finderImageInSandbox:(NSURL *)fileUrl;

@end

NS_ASSUME_NONNULL_END
