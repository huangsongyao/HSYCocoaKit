//
//  AFHTTPRequestOperationManager+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "AFHTTPRequestOperationManager+RACSignal.h"
#import "AFHTTPRequestOperation+RACSignal.h"
#import "NetWorkingManager.h"
#import "NetworkingRequestPathFile.h"
#import "NSError+Message.h"
#import "HSYHUDModel.h"

typedef NS_ENUM(NSUInteger, kRequestMethodType) {
    
    kRequestMethodTypePOST      = 101,  //post类型
    kRequestMethodTypeGET       = 111,  //get类型
};

@implementation AFHTTPRequestOperationManager (RACSignal)

#pragma mark - AF URL

static NSString *重铸完整的请求连接(NSString *urlString)
{
    return [BASE_URL stringByAppendingString:urlString];
}

#pragma mark - AF POST Request

- (RACSignal *)rac_POSTWithPath:(NSString *)path paramters:(NSDictionary *)paramters
{
    NSString *newPath = 重铸完整的请求连接(path);
    return [self rac_POST_Path:newPath paramters:paramters];
}

- (RACSignal *)rac_POST_Path:(NSString *)path paramters:(NSDictionary *)paramters
{
    NSParameterAssert(path);
    //check网络状态，拦截无网状态下的http请求
    return [[[NetWorkingManager shareInstance] getNetworkingReachability] then:^RACSignal *{
        //发送一条post请求
        return [self rac_requestWithMethodType:kRequestMethodTypePOST path:path parameters:paramters];
        
    }];
}

- (RACSignal *)rac_POSTWithPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    //创建信号对象，设置url路径、postBody和请求模式(POST)
    return [[self rac_postRequestPath:path parameters:parameters method:@"POST"] setNameWithFormat:@"<%@: %p> -rac_postRequestPath: %@, parameters: %@",self.class,self,path,parameters];
}

- (RACSignal *)rac_postRequestPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method
{
    return [self rac_requestWithPath:path parameters:parameters method:method];
}

#pragma mark - AF GET Request

- (RACSignal *)rac_GETWithPath:(NSString *)path paramters:(NSDictionary *)paramters
{
    NSString *newPath = 重铸完整的请求连接(path);
    return [self rac_GET_Path:newPath paramters:paramters];
}

- (RACSignal *)rac_GET_Path:(NSString *)path paramters:(NSDictionary *)paramters
{
    NSParameterAssert(path);
    return [[[NetWorkingManager shareInstance] getNetworkingReachability] then:^RACSignal *{
        //发送一条get请求
        return [self rac_requestWithMethodType:kRequestMethodTypeGET path:path parameters:paramters];
        
    }];
}

- (RACSignal *)rac_GETWithPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    return [[self rac_getRequestWithPath:path parameters:parameters method:@"GET"] setNameWithFormat:@"<%@: %p> -rac_getRequestPath: %@, parameters: %@",self.class,self,path,parameters];
}

- (RACSignal *)rac_getRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method
{
    return [self rac_requestWithPath:path parameters:parameters method:method];
}

#pragma mark - RAC For AFNetworking

- (RACSignal *)rac_requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method
{
    NSParameterAssert(path);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:path  relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
        NSLog(@"request %@",request);
        
        //处理完整的request请求
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:nil failure:nil];
        RACSignal* signal = [operation rac_overrideHTTPCompletionBlock];//将AFHTTPRequestOperation对象放入信号管道中进行AF方法的请求，同时回调信号。
        [self.operationQueue addOperation:operation];//添加入队列
        [signal subscribe:subscriber];//发送信号体
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
}

- (RACSignal *)rac_requestWithMethodType:(kRequestMethodType)methodType path:(NSString *)path parameters:(NSDictionary *)parameters
{
    NSParameterAssert(path);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        RACSignal *signal = nil;  //创建信号，管道中对AF方法进行请求，回调使用signal返回。
        switch (methodType) {
            case kRequestMethodTypeGET: {
                signal = [self rac_GETWithPath:path parameters:parameters];
            }
                break;
            case kRequestMethodTypePOST: {
                signal = [self rac_POSTWithPath:path parameters:parameters];
            }
                break;
            default:
                break;
        }
        
        //将回调的tuple对象逐级向上发送
        [signal subscribeNext:^(RACTuple *tuple) {
            
            AFHTTPRequestOperation *requestOperation = (AFHTTPRequestOperation *)tuple.first;
            NSDictionary *heads = [requestOperation response].allHeaderFields;
            NSLog(@"\n//=====================%@====================//\n", heads);
            
            NSString *value = [heads valueForKey:kHttpErrorHeadKey];
            if (value) {
                [subscriber sendError:[NSError errorWithErrorType:(kAFNetworkingStatusErrorType)[value integerValue]]];
                [HSYHUDHelper showHUDViewForMessage:value];
                [subscriber sendCompleted];
            } else {
                //把获取到网络回调的数据逐级上传
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }
        } error:^(NSError *error) {
            NSLog(@"error: %@\n", error);
            [subscriber sendError:error];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}


@end
