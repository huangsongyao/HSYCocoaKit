//
//  AFHTTPSessionManager+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import "AFHTTPSessionManager+RACSignal.h"
#import "NetworkingRequestPathFile.h"
#import "NetWorkingManager.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitNetworkingRequestModel) {
    
    kHSYCocoaKitNetworkingRequestModel_get,
    kHSYCocoaKitNetworkingRequestModel_post,
    
};

@implementation AFHTTPSessionManager (RACSignal)

#pragma mark - Get & Post Request

static NSString *重铸完整的请求连接(NSString *urlPath)
{
    NSString *urlString = [NetWorkingManager urlFromPath:urlPath];
    return urlString;
}

- (RACSignal *)rac_getRequest:(NSString *)urlPath parameters:(id)parameters
{
    return [self rac_getRequest:urlPath parameters:parameters setHeaders:@[]];
}

- (RACSignal *)rac_getRequest:(NSString *)urlPath
                   parameters:(id)parameters
                   setHeaders:(NSArray<NSDictionary *> *)headers
{
    NSString *url = 重铸完整的请求连接(urlPath);
    return [self rac_request:kHSYCocoaKitNetworkingRequestModel_get setHeaders:headers url:url parameters:parameters];
}

- (RACSignal *)rac_postRequest:(NSString *)urlPath parameters:(id)parameters
{
    return [self rac_postRequest:urlPath parameters:parameters setHeaders:@[]];
}

- (RACSignal *)rac_postRequest:(NSString *)urlPath
                    parameters:(id)parameters
                    setHeaders:(NSArray<NSDictionary *> *)headers
{
    NSString *url = 重铸完整的请求连接(urlPath);
    return [self rac_request:kHSYCocoaKitNetworkingRequestModel_post setHeaders:headers url:url parameters:parameters];
}

#pragma mark - RAC

- (RACSignal *)rac_request:(kHSYCocoaKitNetworkingRequestModel)type
                setHeaders:(NSArray<NSDictionary *> *)headers
                       url:(NSString *)url
                parameters:(id)parameters
{
    for (NSDictionary *header in headers) {
        [self.requestSerializer setValue:header.allValues.firstObject forHTTPHeaderField:header.allKeys.firstObject];
    }
    NSParameterAssert(url);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RACSignal *signal = [self getModel_3x_Request:url parameters:parameters];
        if (type == kHSYCocoaKitNetworkingRequestModel_post) {
            signal = [self postModel_3x_Request:url parameters:parameters];
        }
        [signal subscribeNext:^(RACTuple *tuple) {
            [subscriber sendNext:tuple];
            [subscriber sendCompleted];
        } error:^(NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

- (RACSignal *)rac_request:(kHSYCocoaKitNetworkingRequestModel)type
                       url:(NSString *)url
                parameters:(id)parameters
{
    return [self rac_request:type setHeaders:@[] url:url parameters:parameters];
}

#pragma mark - Get Model

- (RACSignal *)getModel_3x_Request:(NSString *)url parameters:(id)parameters
{
    return [self getModel_3x_Request:url parameters:parameters taskProgress:^(NSProgress *downloadProgress) {
        NSLog(@"get request progress = %f", downloadProgress.fractionCompleted * 100);
    }];
}


- (RACSignal *)getModel_3x_Request:(NSString *)url
                        parameters:(id)parameters
                      taskProgress:(void(^)(NSProgress *downloadProgress))progress
{
    return [[[NetWorkingManager shareInstance] networking_3x_Reachability] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            __block NSURLSessionDataTask *getTask = [self GET:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self.class logRequestHeaders:task];
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self.class logRequestHeaders:task];
                [self.class logRequestError:error];
                [subscriber sendError:error];
            }];
            return [RACDisposable disposableWithBlock:^{
                [getTask cancel];
            }];
        }];
    }];
}


#pragma mark - Post Model

- (RACSignal *)postModel_3x_Request:(NSString *)url parameters:(id)parameters
{
    return [self postModel_3x_Request:url parameters:parameters taskProgress:^(NSProgress *downloadProgress) {
        NSLog(@"post request progress = %f", downloadProgress.fractionCompleted * 100);
    }];
}

- (RACSignal *)postModel_3x_Request:(NSString *)url
                         parameters:(id)parameters
                       taskProgress:(void(^)(NSProgress *downloadProgress))progress
{
    return [[[NetWorkingManager shareInstance] networking_3x_Reachability] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            __block NSURLSessionDataTask *postTask = [self POST:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self.class logRequestHeaders:task];
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self.class logRequestHeaders:task];
                [self.class logRequestError:error];
                [subscriber sendError:error];
            }];
            return [RACDisposable disposableWithBlock:^{
                [postTask cancel];
            }];
        }];
    }];
}

#pragma mark - Download 

+ (RACSignal *)downloadFileRequestUrl:(NSURL *)url
                        fileCachePath:(NSString *)filePath
                   completionProgress:(void(^)(NSProgress *progress, CGFloat downloadProgress))progress
                   cancelByResumeData:(void(^)(NSData *resumeData))cancel
{
    NSParameterAssert(url);
    NSParameterAssert(filePath);
    return [[[NetWorkingManager shareInstance] networking_3x_Reachability] then:^RACSignal *{
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                if (progress) {
                    CGFloat fractionCompleted = MIN((downloadProgress.fractionCompleted * 100), 1.0f);
                    progress(downloadProgress, fractionCompleted);
                }
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                NSURL *fileURL = [NSURL fileURLWithPath:filePath];
                return fileURL;
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                if (!error) {
                    [self.class logRequestError:error];
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

#pragma mark - Logs

+ (void)logRequestError:(NSError *)error
{
    if (error) {
        NSLog(@"request failure, error : %@", error);
    }
}

+ (void)logRequestHeaders:(NSURLSessionDataTask *)task
{
    if ([task isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        NSLog(@"\n request headers are : %@ \n", allHeaders);
    } else {
        NSLog(@"\n request task : %@ \n", task);
    }
}

@end
