//
//  AFURLSessionManager+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "AFURLSessionManager+RACSignal.h"
#import "HSYNetWorkingManager.h"

@implementation AFURLSessionManager (RACSignal)

#pragma mark - Download

- (RACSignal *)hsy_downloadFileRequestUrl:(NSURL *)url
                            fileCachePath:(NSString *)filePath
                            setHTTPMethod:(kHSYCocoaKitNetworkingRequestModel)type
                       completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress, NSURLSessionDownloadTask *downloadTask))progress
                       cancelByResumeData:(void(^)(NSData *resumeData))cancel
{
    NSParameterAssert(url);
    NSParameterAssert(filePath);
    return [[[HSYNetWorkingManager shareInstance] hsy_networking_3x_Reachability] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            NSString *method = [AFHTTPSessionManager hsy_methodFromNetworkingRequestModel:type];
            if (method.length > 0) {
                [request setHTTPMethod:[AFHTTPSessionManager hsy_methodFromNetworkingRequestModel:type]];
            }
            __block NSURLSessionDownloadTask *downloadTask = [self downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    CGFloat fractionCompleted = MIN((downloadProgress.fractionCompleted * 100), 1.0f);
                    progress(downloadProgress, fractionCompleted, downloadTask);
                }
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                return fileURL;
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                if (!error) {
                    [AFHTTPSessionManager hsy_logRequestError:error];
                    [subscriber sendError:error];
                } else {
                    RACTuple *tuple = RACTuplePack(response, filePath);
                    [subscriber sendNext:tuple];
                    [subscriber sendCompleted];
                }
            }];
            [downloadTask resume];
            return [RACDisposable disposableWithBlock:^{
                [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                    if (cancel) {
                        cancel(resumeData);
                    }
                }];
            }];
        }];
    }];
}

- (RACSignal *)hsy_downloadFileRequestUrl:(NSURL *)url
                            fileCachePath:(NSString *)filePath
                       completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress, NSURLSessionDownloadTask *downloadTask))progress
                       cancelByResumeData:(void(^)(NSData *resumeData))cancel
{
    return [self hsy_downloadFileRequestUrl:url
                              fileCachePath:filePath
                              setHTTPMethod:kHSYCocoaKitNetworkingRequestModel_default
                         completionProgress:progress
                         cancelByResumeData:cancel];
}

#pragma mark - Upload

- (RACSignal *)hsy_uploadFileRequestUrl:(NSURL *)url
                               filePath:(NSString *)path
                          setHTTPMethod:(kHSYCocoaKitNetworkingRequestModel)type
                     completionProgress:(void(^)(NSProgress *progress, CGFloat uploadProgress, NSURLSessionUploadTask *uploadTask))progress
{
    NSParameterAssert(url);
    NSParameterAssert(path);
    return [[[HSYNetWorkingManager shareInstance] hsy_networking_3x_Reachability] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            NSString *method = [AFHTTPSessionManager hsy_methodFromNetworkingRequestModel:type];
            if (method.length > 0) {
                [request setHTTPMethod:[AFHTTPSessionManager hsy_methodFromNetworkingRequestModel:type]];
            }
            NSURL *pathURL = [NSURL fileURLWithPath:path];
            __block NSURLSessionUploadTask *uploadTask = [self uploadTaskWithRequest:request fromFile:pathURL progress:^(NSProgress * _Nonnull uploadProgress) {
                if (progress) {
                    CGFloat fractionCompleted = MIN((uploadProgress.fractionCompleted * 100), 1.0f);
                    progress(uploadProgress, fractionCompleted, uploadTask);
                }
            } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                if (error) {
                    [subscriber sendError:error];
                } else {
                    RACTuple *tuple = RACTuplePack(response, responseObject);
                    [subscriber sendNext:tuple];
                    [subscriber sendCompleted];
                }
            }];
            [uploadTask resume];
            return [RACDisposable disposableWithBlock:^{
                [uploadTask cancel];
            }];
        }];
    }];
}

- (RACSignal *)hsy_uploadFileRequestUrl:(NSURL *)url
                               filePath:(NSString *)path
                     completionProgress:(void(^)(NSProgress *progress, CGFloat uploadProgress, NSURLSessionUploadTask *uploadTask))progress
{
    return [self hsy_uploadFileRequestUrl:url
                                 filePath:path
                            setHTTPMethod:kHSYCocoaKitNetworkingRequestModel_default
                       completionProgress:progress];
}

@end
