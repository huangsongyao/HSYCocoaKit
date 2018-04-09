//
//  AFHTTPSessionManager+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface AFHTTPSessionManager (RACSignal)

#pragma mark - Get

/**
 get请求

 @param urlPath URL的字段
 @param parameters 参数
 @return RACSignal
 */
- (RACSignal *)rac_getRequest:(NSString *)urlPath parameters:(id)parameters;

/**
 get请求，允许设置额外的请求头信息

 @param urlPath URL的字段
 @param parameters 参数
 @param headers 请求头信息
 @return RACSignal
 */
- (RACSignal *)rac_getRequest:(NSString *)urlPath parameters:(id)parameters setHeaders:(NSArray<NSDictionary *> *)headers;

#pragma mark - Post

/**
 post请求

 @param urlPath URL的字段
 @param parameters 参数
 @return RACSignal
 */
- (RACSignal *)rac_postRequest:(NSString *)urlPath parameters:(id)parameters;

/**
 post请求，允许设置额外的请求头信息

 @param urlPath URL的字段
 @param parameters 参数
 @param headers 请求头信息
 @return RACSignal
 */
- (RACSignal *)rac_postRequest:(NSString *)urlPath parameters:(id)parameters setHeaders:(NSArray<NSDictionary *> *)headers;

#pragma mark - Download File

/**
 文件下载

 @param url 下载的远端地址
 @param filePath 存入本地的一个绝对路径
 @param progress 下载进度的回调
 @param cancel 下载失败后返回的已下载的data内容
 @return RACSignal文件下载结果信号
 */
+ (RACSignal *)downloadFileRequestUrl:(NSURL *)url
                        fileCachePath:(NSString *)filePath
                   completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress))progress
                   cancelByResumeData:(void(^)(NSData *resumeData))cancel;

#pragma mark - Upload File

/**
 文件上传

 @param url 上传的远端地址
 @param path 要上传的文件的本地绝对路径
 @param progress 文件上传的进度回调
 @return RACSignal文件上传结果信号
 */
+ (RACSignal *)uploadFileRequestUrl:(NSURL *)url
                           filePath:(NSString *)path
                 completionProgress:(void(^)(NSProgress *progress, CGFloat uploadProgress))progress;

@end
