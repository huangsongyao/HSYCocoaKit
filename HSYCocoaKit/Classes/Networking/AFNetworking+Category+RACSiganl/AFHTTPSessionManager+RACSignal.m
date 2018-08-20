//
//  AFHTTPSessionManager+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import "AFHTTPSessionManager+RACSignal.h"
#import "HSYNetWorkingManager.h"

NSString *const kHSYCocoaKitAFHTTPSessionRequestAllHeaders    = @"0awfjsfjaweofjw09fwefsd";

@implementation AFHTTPSessionManager (RACSignal)

#pragma mark - Get & Post Request

static NSString *重铸完整的请求连接(NSString *urlPath)
{
    NSString *urlString = [HSYNetWorkingManager hsy_urlFromPath:urlPath];
    NSLog(@"\n request urlString = %@ \n", urlString);
    return urlString;
}

- (RACSignal *)hsy_rac_getRequest:(NSString *)urlPath parameters:(id)parameters
{
    return [self hsy_rac_getRequest:urlPath parameters:parameters setHeaders:@[]];
}

- (RACSignal *)hsy_rac_getRequest:(NSString *)urlPath
                       parameters:(id)parameters
                       setHeaders:(NSArray<NSDictionary *> *)headers
{
    NSString *url = 重铸完整的请求连接(urlPath);
    return [self hsy_rac_request:kHSYCocoaKitNetworkingRequestModel_get setHeaders:headers url:url parameters:parameters];
}

- (RACSignal *)hsy_rac_postRequest:(NSString *)urlPath parameters:(id)parameters
{
    return [self hsy_rac_postRequest:urlPath parameters:parameters setHeaders:@[]];
}

- (RACSignal *)hsy_rac_postRequest:(NSString *)urlPath
                        parameters:(id)parameters
                        setHeaders:(NSArray<NSDictionary *> *)headers
{
    NSString *url = 重铸完整的请求连接(urlPath);
    return [self hsy_rac_request:kHSYCocoaKitNetworkingRequestModel_post setHeaders:headers url:url parameters:parameters];
}

#pragma mark - RAC

- (RACSignal *)hsy_rac_request:(kHSYCocoaKitNetworkingRequestModel)type
                    setHeaders:(NSArray<NSDictionary *> *)headers
                           url:(NSString *)url
                    parameters:(id)parameters
{
    for (NSDictionary *header in headers) {
        [self.requestSerializer setValue:header.allValues.firstObject forHTTPHeaderField:header.allKeys.firstObject];
    }
    NSParameterAssert(url);
    [[[HSYNetWorkingManager shareInstance] hsy_networking_3x_Reachability] subscribeError:^(NSError *error) {
        NSLog(@"++++++++++++++++++++++++++++error = %@++++++++++++++++++++++++++++", error);
    } completed:^{
        NSLog(@"++++++++++++++++++++++++++++completed+++++++++++++++++++++++++++++++");
    }];
    RACSignal *signal = [self hsy_getModel_3x_Request:url parameters:parameters];
    if (type == kHSYCocoaKitNetworkingRequestModel_post) {
        signal = [self hsy_postModel_3x_Request:url parameters:parameters];
    }
    return signal;
}

#pragma mark - Get Model

- (RACSignal *)hsy_getModel_3x_Request:(NSString *)url parameters:(id)parameters
{
    return [self hsy_getModel_3x_Request:url parameters:parameters taskProgress:^(NSProgress *downloadProgress) {
        NSLog(@"get request progress = %f", downloadProgress.fractionCompleted * 100);
    }];
}


- (RACSignal *)hsy_getModel_3x_Request:(NSString *)url
                            parameters:(id)parameters
                          taskProgress:(void(^)(NSProgress *downloadProgress))progress
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self GET:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.class hsy_logRequestHeaders:task];
            RACTuple *tuple = RACTuplePack(task, responseObject);
            [subscriber sendNext:tuple];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.class hsy_logRequestHeaders:task];
            [self.class hsy_logRequestError:error];
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_getModel_3x_Request:parameters:taskProgress:” file is “AFHTTPSessionManager+RACSignal.h”");
        }];
    }];
}


#pragma mark - Post Model

- (RACSignal *)hsy_postModel_3x_Request:(NSString *)url parameters:(id)parameters
{
    return [self hsy_postModel_3x_Request:url parameters:parameters taskProgress:^(NSProgress *downloadProgress) {
        NSLog(@"post request progress = %f", downloadProgress.fractionCompleted * 100);
    }];
}

- (RACSignal *)hsy_postModel_3x_Request:(NSString *)url
                             parameters:(id)parameters
                           taskProgress:(void(^)(NSProgress *downloadProgress))progress
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self POST:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self.class hsy_logRequestHeaders:task];
            RACTuple *tuple = RACTuplePack(task, responseObject);
            [subscriber sendNext:tuple];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.class hsy_logRequestHeaders:task];
            [self.class hsy_logRequestError:error];
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_postModel_3x_Request:parameters:taskProgress:” file is “AFHTTPSessionManager+RACSignal.h”");
        }];
    }];
}

#pragma mark - Logs

+ (void)hsy_logRequestError:(NSError *)error
{
    if (error) {
        NSLog(@"request failure, error : %@", error);
    }
}

+ (void)hsy_logRequestHeaders:(NSURLSessionDataTask *)task
{
    NSLog(@"\n request task : %@ \n", task);
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSDictionary *allHeaders = response.allHeaderFields;
        [[NSNotificationCenter defaultCenter] postNotificationName:kHSYCocoaKitAFHTTPSessionRequestAllHeaders object:allHeaders];
        NSLog(@"\n request headers are : %@ \n", allHeaders);
    }
}

#pragma mark - HTTPMethod

+ (NSString *)hsy_methodFromNetworkingRequestModel:(kHSYCocoaKitNetworkingRequestModel)model
{
    if (model == kHSYCocoaKitNetworkingRequestModel_get) {
        return @"GET";
    } else if (model == kHSYCocoaKitNetworkingRequestModel_post) {
        return @"POST";
    }
    return nil;
}

@end
