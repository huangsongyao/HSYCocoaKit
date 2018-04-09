//
//  AFURLSessionManager+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "AFURLSessionManager+RACSignal.h"
#import "HSYNetWorkingManager.h"
#import "AFHTTPSessionManager+RACSignal.h"

@implementation AFURLSessionManager (RACSignal)

#pragma mark - Download

- (RACSignal *)downloadFileRequestUrl:(NSURL *)url
                        fileCachePath:(NSString *)filePath
                   completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress, NSURLSessionDownloadTask *downloadTask))progress
                   cancelByResumeData:(void(^)(NSData *resumeData))cancel
{
    NSParameterAssert(url);
    NSParameterAssert(filePath);
    return [[[HSYNetWorkingManager shareInstance] networking_3x_Reachability] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
                    [AFHTTPSessionManager logRequestError:error];
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

#pragma mark - Upload

- (RACSignal *)uploadFileRequestUrl:(NSURL *)url
                           filePath:(NSString *)path
                 completionProgress:(void(^)(NSProgress *progress, CGFloat uploadProgress, NSURLSessionUploadTask *uploadTask))progress
{
    NSParameterAssert(url);
    NSParameterAssert(path);
    return [[[HSYNetWorkingManager shareInstance] networking_3x_Reachability] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
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

@end
