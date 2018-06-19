//
//  HSYBaseWebModel.h
//  Pods
//
//  Created by huangsongyao on 2017/3/31.
//
//

#import "HSYBaseRefleshModel.h"

@interface HSYBaseWebModel : HSYBaseRefleshModel

@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSString *htmlString;
@property (nonatomic, copy, readonly) NSString *runNativeName;

/**
 初始化，用于http开头的URL链接
 
 @param urlString url的链接地址
 @param name js调用native需要的触发postMessage方法的对象的名称
 @return self
 */
- (instancetype)initWithUrlString:(NSString *)urlString runNativeName:(NSString *)name;

/**
 初始化，用于HTML文件或者HTML格式的web数据
 
 @param htmlString HTML数据
 @param name js调用native需要的触发postMessage方法的对象的名称
 @return self
 */
- (instancetype)initWithHtmlString:(NSString *)htmlString runNativeName:(NSString *)name;

@end
