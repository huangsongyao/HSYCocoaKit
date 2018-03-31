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

+ (RACSignal *)downloadFileRequestUrl:(NSURL *)url
                        fileCachePath:(NSString *)filePath
                   completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress))progress
                   cancelByResumeData:(void(^)(NSData *resumeData))cancel;

@end
