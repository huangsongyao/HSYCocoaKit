//
//  HSYNetWorkingManager.m
//  Pods
//
//  Created by huangsongyao on 2018/4/2.
//
//

#import "HSYNetWorkingManager.h"
#import "NSError+Message.h"

static NSString *kHSYCocoaKitDefaultBaseUrlAddress  = @"";
static HSYNetWorkingManager *networkingManager;

//***********************************************************************************************

@implementation AFHTTPSessionManager (SetTimeout)

- (void)hsy_setHTTPSessionManagerTimeoutInterval:(NSTimeInterval)timeout
{
    NSTimeInterval realTimeInterval = timeout;
    if (realTimeInterval < 0.0f) {
        realTimeInterval = 60.0f;
    }
    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.requestSerializer.timeoutInterval = realTimeInterval;
    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
}

@end

//***********************************************************************************************

@interface HSYNetWorkingManager ()

@end

@implementation HSYNetWorkingManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkingManager = [HSYNetWorkingManager new];
    });
    return networkingManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self hsy_reset];
    }
    return self;
}

#pragma mark - Load

+ (NSTimeInterval)hsy_requestSerializerTimeout
{
    return 60.0f;
}

- (void)hsy_reset
{
    _httpSessionManager = [self hsy_defaultHTTPSessionManager];
    _fileSessionManager = [self hsy_defaultURLSessionManager];
}

#pragma mark - Address

- (void)hsy_setNetworkBaseUrl:(NSString *)baseUrl
{
    BOOL hasHttp = [baseUrl hasPrefix:@"http"];
    if (!hasHttp) {
        NSAssert(hasHttp != NO, @"域名地址必须由【http+IP+Port】组成!");
    }
    kHSYCocoaKitDefaultBaseUrlAddress = baseUrl;
}

+ (NSString *)hsy_urlFromPath:(NSString *)path
{
    if ([path hasPrefix:@"http"]) {
        return path;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",kHSYCocoaKitDefaultBaseUrlAddress, path];
    if (![urlString containsString:@"http"]) {
        NSLog(@"链接不含有http字符串！链接不完整！");
        return nil;
    }
    return urlString;
}

#pragma mark - All Headers

- (void)hsy_setHTTPSessionHeaders:(NSArray<NSDictionary *> *)headers
{
    for (NSDictionary *header in headers) {
        [self.httpSessionManager.requestSerializer setValue:header.allValues.firstObject forHTTPHeaderField:header.allKeys.firstObject];
    }
}

#pragma mark - Request & response Statement

- (void)hsy_statementHTTPSerializer:(kHSYCocoaKitHTTPStatementSerializer)serializer
{
    switch (serializer) {
        case kHSYCocoaKitHTTPStatementSerializerHTTPRequestSerializerAndHTTPResponseSerializer: {
            self.httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            self.httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
            break;
        case kHSYCocoaKitHTTPStatementSerializerHTTPRequestSerializerAndJSONResponseSerializer: {
            self.httpSessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
            self.httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
            break;
        case kHSYCocoaKitHTTPStatementSerializerJSONRequestSerializerAndHTTPResponseSerializer: {
            self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            self.httpSessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        }
            break;
        case kHSYCocoaKitHTTPStatementSerializerJSONRequestSerializerAndJSONResponseSerializer: {
            self.httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
            self.httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        }
            break;
        default:
            break;
    }
}

#pragma mark - >=3.0f version

- (RACSignal *)hsy_networking_3x_Reachability
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [HSYNetWorkingManager hsy_observer_3x_network_startMonitoring:^BOOL(AFNetworkReachabilityStatus status, BOOL hasNetwork) {
            if (hasNetwork) {
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:[NSError hsy_errorWithErrorType:kAFNetworkingStatusErrorTypeNone]];
            }
            return YES;
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_networking_3x_Reachability” class is %@", NSStringFromClass(self.class));
        }];
    }];
}

- (void)hsy_observer_3x_NetworkReachabilityOfNext:(BOOL(^)(AFNetworkReachabilityStatus status, BOOL hasNetwork))next
{
    [HSYNetWorkingManager hsy_observer_3x_network_startMonitoring:^BOOL(AFNetworkReachabilityStatus status, BOOL hasNetwork) {
        if (next) {
            return next(status, hasNetwork);
        }
        return YES;
    }];
}

+ (void)hsy_observer_3x_network_startMonitoring:(BOOL(^)(AFNetworkReachabilityStatus status, BOOL hasNetwork))start
{
    AFNetworkReachabilityManager *networkStatusManager = [AFNetworkReachabilityManager sharedManager];
    @weakify(networkStatusManager);
    [networkStatusManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        @strongify(networkStatusManager);
        if (start) {
            BOOL hasNetwork = !AFNetworkReachabilityStatusNotReachable;
            BOOL stopMonintoring = start(status, hasNetwork);
            if (stopMonintoring) {
                [networkStatusManager stopMonitoring];
            }
        }
    }];
    [networkStatusManager startMonitoring];
}

#pragma mark - Session Manager

- (AFHTTPSessionManager *)hsy_defaultHTTPSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self hsy_statementHTTPSerializer:kHSYCocoaKitHTTPStatementSerializerJSONRequestSerializerAndJSONResponseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"image/jpeg", @"text/plain", nil];
    //设置请求超时时间，如果本类的类族[本类或者子类]对象重置了“requestSerializer”或“responseSerializer”，则需要在本类的类族[本类或者子类]对象对象中重置
    [manager hsy_setHTTPSessionManagerTimeoutInterval:[self.class hsy_requestSerializerTimeout]];
    
    return manager;
}

- (AFURLSessionManager *)hsy_defaultURLSessionManager
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}


@end
