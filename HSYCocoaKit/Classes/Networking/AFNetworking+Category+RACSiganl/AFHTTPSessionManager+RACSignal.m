//
//  AFHTTPSessionManager+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import "AFHTTPSessionManager+RACSignal.h"
#import "HSYNetWorkingManager.h"
#import "NSError+Message.h"

NSString *const kHSYCocoaKitAFHTTPSessionRequestAllHeaders    = @"0awfjsfjaweofjw09fwefsd";
NSString *const kHSYCocoaKitAFHTTPSessionRequestFilters       = @"ofpiwe3fjiaweofij9w84fafas";

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
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self GET:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [AFHTTPSessionManager hsy_logRequestHeaders:task];
            [self.class hsy_filter:@{responseObject : task} sendMessage:^(RACTuple *tuple) {
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [AFHTTPSessionManager hsy_logRequestHeaders:task];
            [AFHTTPSessionManager hsy_logRequestError:error];
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
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self POST:url parameters:parameters progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [AFHTTPSessionManager hsy_logRequestHeaders:task];
            [self.class hsy_filter:@{responseObject : task} sendMessage:^(RACTuple *tuple) {
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [AFHTTPSessionManager hsy_logRequestHeaders:task];
            [AFHTTPSessionManager hsy_logRequestError:error];
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_postModel_3x_Request:parameters:taskProgress:” file is “AFHTTPSessionManager+RACSignal.h”");
        }];
    }];
}

#pragma mark - Filter

+ (void)hsy_filter:(NSDictionary *)response sendMessage:(void(^)(RACTuple *tuple))send
{
    id responseObject = response.allKeys.firstObject;
    NSURLSessionDataTask *task = response.allValues.firstObject;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSString *key = [HSYNetWorkingManager hsy_filterStatusCodes].allKeys.firstObject;
        NSArray *filters = [HSYNetWorkingManager hsy_filterStatusCodes].allValues.firstObject;
        id value = responseObject[key];
        if ([filters containsObject:value]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHSYCocoaKitAFHTTPSessionRequestFilters object:response];
            return;
        }
    }
    RACTuple *tuple = RACTuplePack(task, responseObject);
    send(tuple);
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
