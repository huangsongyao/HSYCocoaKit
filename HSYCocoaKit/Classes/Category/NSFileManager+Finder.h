//
//  NSFileManager+Finder.h
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Finder)


/**
 根据文件的名称的后缀类型，到本地资源文件和沙盒中寻找该文件的路径，沙盒路径寻找对象为doucment、cache和library

 @param name 文件名称
 @param type 文件后缀类型
 @return 文件路径，如果不存在，则返回空字符串
 */
+ (NSString *)finderFileFromName:(NSString *)name fileType:(NSString *)type;

/**
 根据文件的名称的后缀类型，到本地资源文件和沙盒中寻找该文件的路径，沙盒路径寻找对象为doucment、cache和library，如果找到了则表示该文件存在，否则不存在

 @param name 文件名称
 @param type 文件后缀类型
 @return 存在则返回YES
 */
+ (BOOL)fileExist:(NSString *)name fileType:(NSString *)type;

@end
