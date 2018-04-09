//
//  AFURLSessionManager+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "AFHTTPSessionManager+RACSignal.h"

@interface AFURLSessionManager (RACSignal)

#pragma mark - Download File 

/**
 文件下载，默认不设置method
 
 @param url 下载的远端地址
 @param filePath 存入本地的一个绝对路径
 @param progress 下载进度的回调
 @param cancel 下载失败后返回的已下载的data内容
 @return RACSignal文件下载结果信号
 */
- (RACSignal *)downloadFileRequestUrl:(NSURL *)url
                        fileCachePath:(NSString *)filePath
                   completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress, NSURLSessionDownloadTask *downloadTask))progress
                   cancelByResumeData:(void(^)(NSData *resumeData))cancel;

/**
 文件下载，

 @param url 下载的远端地址
 @param filePath 存入本地的一个绝对路径
 @param type method的类型，get或者post
 @param progress 下载进度的回调
 @param cancel 下载失败后返回的已下载的data内容
 @return RACSignal文件下载结果信号
 */
- (RACSignal *)downloadFileRequestUrl:(NSURL *)url
                        fileCachePath:(NSString *)filePath
                        setHTTPMethod:(kHSYCocoaKitNetworkingRequestModel)type
                   completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress, NSURLSessionDownloadTask *downloadTask))progress
                   cancelByResumeData:(void(^)(NSData *resumeData))cancel;

#pragma mark - Upload File

/**
 文件上传
 
 @param url 上传的远端地址
 @param path 要上传的文件的本地绝对路径
 @param progress 文件上传的进度回调
 @return RACSignal文件上传结果信号
 */
- (RACSignal *)uploadFileRequestUrl:(NSURL *)url
                           filePath:(NSString *)path
                 completionProgress:(void(^)(NSProgress *progress, CGFloat uploadProgress, NSURLSessionUploadTask *uploadTask))progress;

/**
 文件上传，默认不设置method

 @param url 上传的远端地址
 @param path 要上传的文件的本地绝对路径
 @param type method的类型，get或者post
 @param progress 文件上传的进度回调
 @return RACSignal文件上传结果信号
 */
- (RACSignal *)uploadFileRequestUrl:(NSURL *)url
                           filePath:(NSString *)path
                      setHTTPMethod:(kHSYCocoaKitNetworkingRequestModel)type
                 completionProgress:(void(^)(NSProgress *progress, CGFloat uploadProgress, NSURLSessionUploadTask *uploadTask))progress;
@end
