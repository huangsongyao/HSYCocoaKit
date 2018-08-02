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
 根据文件名+后缀类型的key-value进行文件索引，调用“- finderFileFromName:fileType:”方法

 @param resources key-value的集合，格式为:@[@{@"文件A的后缀类型" : @"文件A的名称"}, @{@"文件B的后缀类型" : @"文件B的名称"}, ...]
 @return 文件路径，如果不存在，则返回空字符串
 */
+ (NSString *)finderFileFromResources:(NSArray<NSDictionary *> *)resources;

/**
 根据文件的名称的后缀类型，到本地资源文件和沙盒中寻找该文件的路径，沙盒路径寻找对象为doucment、cache和library，如果存在则返回该资源的本地路径或本地沙盒路径，由于搜索内容涵盖doucment、cache和library，最好不要再主线程上使用该方法做太多的耗时操作，以免出现卡顿

 @param name 文件名称
 @param type 文件后缀类型
 @return 文件路径，如果不存在，则返回空字符串
 */
+ (NSString *)finderFileFromName:(NSString *)name fileType:(NSString *)type;

/**
 根据文件的名称的后缀类型，到本地资源文件和沙盒中寻找该文件的路径，沙盒路径寻找对象为doucment、cache和library，如果找到了则表示该文件存在，否则不存在，由于搜索内容涵盖doucment、cache和library，最好不要再主线程上使用该方法做太多的耗时操作，以免出现卡顿

 @param name 文件名称
 @param type 文件后缀类型
 @return 存在则返回YES
 */
+ (BOOL)fileExist:(NSString *)name fileType:(NSString *)type;

@end
