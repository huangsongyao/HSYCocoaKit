//
//  NetWorkingManager.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NetWorkingManager.h"
#import "NetworkingRequestPathFile.h"
#import "NSError+Message.h"

static NetWorkingManager *networkingManager;

static NSString *kHSYValueKey  = @"HSYValueKey";

@interface NetWorkingManager ()

@end

@implementation NetWorkingManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkingManager = [NetWorkingManager new];
    });
    return networkingManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.httpManager = [self afnHttpRequestOperationManagerWithBaseURL:[NSURL URLWithString:BASE_URL] isRequestJSON:YES];
    }
    return self;
}


#pragma mark - POST AF Manager

- (AFHTTPRequestOperationManager *)afnHttpRequestOperationManagerWithBaseURL:(NSURL *)baseURL isRequestJSON:(BOOL)isRequestJSON
{
    return [self createRequestOperationManagerWithBaseURL:baseURL
                                            isRequestJSON:isRequestJSON
                                           isResponseJSON:YES
                                                  isHTTPS:YES
                                             contentTypes:[[NSSet alloc] initWithObjects:@"application/json", @"text/html", nil]
                                          timeoutInterval:30.0f
                              maxConcurrentOperationCount:3];
}

- (AFHTTPRequestOperationManager *)createRequestOperationManagerWithBaseURL:(NSURL *)baseURL
                                                              isRequestJSON:(BOOL)isRequestJSON
                                                             isResponseJSON:(BOOL)isResponseJSON
                                                                    isHTTPS:(BOOL)isHTTPS
                                                               contentTypes:(NSSet *)contentTypes
                                                            timeoutInterval:(NSTimeInterval)timeoutInterval
                                                maxConcurrentOperationCount:(NSInteger)maxConcurrentOperationCount
{
    AFHTTPRequestOperationManager *requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    if (isRequestJSON) {
        requestOperationManager.requestSerializer = [AFJSONRequestSerializer serializer];                   //申明请求的数据是json类型
    }
    if (isResponseJSON) {
        requestOperationManager.responseSerializer = [AFJSONResponseSerializer serializer];                 //申明返回的结果是json类型
    }
    
    if (isHTTPS) {
        //创建安全策略对象,即：设置AFNetworking允许自签名的.cer证书的https请求（需要把服务器给的SSL证书转为.cer证书，添加到工程中）
        AFSecurityPolicy * security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate]; //设置证书
        security.allowInvalidCertificates = YES;                                                            //由于是自签证证书 afnnetworking 会认为是无效的 设置为允许
        security.validatesDomainName = NO;                                                                  //验证证书绑定的域
        [requestOperationManager setSecurityPolicy:security];
    }
    
    requestOperationManager.responseSerializer.acceptableContentTypes = contentTypes;                       //如果报接受类型不一致请替换一致text/html或别的
    requestOperationManager.requestSerializer.timeoutInterval = timeoutInterval;                            //超时时间
    [requestOperationManager.requestSerializer setValue:kHSYValueKey forHTTPHeaderField:kHttpHeaderFieldKey];
    requestOperationManager.operationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount;       //队列个数
    
    return requestOperationManager;
}

#pragma mark - Get Network Status

- (RACSignal *)getNetworkingReachability
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        AFHTTPRequestOperationManager *requestOperationManager = [[AFHTTPRequestOperationManager alloc] init];
        [requestOperationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            _isReachable = status;
            NSLog(@"isReachable:%ld\n", (long)status);
            if (status == AFNetworkReachabilityStatusReachableViaWWAN ||
                status == AFNetworkReachabilityStatusReachableViaWiFi ||
                status == AFNetworkReachabilityStatusUnknown) {
                
                [subscriber sendNext:@(status)]; //发送当前网络类型，WAN/WIFI/Unknown
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:[NSError errorWithErrorType:kAFNetworkingStatusErrorTypeNone]];//无网络状态的报错
            }
        }];
        // 开启检测
        [requestOperationManager.reachabilityManager startMonitoring];
        return nil;
    }];
}

@end
