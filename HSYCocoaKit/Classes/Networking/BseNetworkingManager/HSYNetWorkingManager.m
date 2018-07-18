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
        _httpSessionManager = [self hsy_defaultHTTPSessionManager:YES];
        _fileSessionManager = [self hsy_defaultURLSessionManager];
    }
    return self;
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
        AFNetworkReachabilityManager *networkStatusManager = [AFNetworkReachabilityManager sharedManager];
        [networkStatusManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status != AFNetworkReachabilityStatusNotReachable) {
                [subscriber sendCompleted];
            } else {
                [subscriber sendError:[NSError hsy_errorWithErrorType:kAFNetworkingStatusErrorTypeNone]];
            }
        }];
        [networkStatusManager startMonitoring];
        return [RACDisposable disposableWithBlock:^{}];
    }];
}

- (void)hsy_observer_3x_NetworkReachabilityOfNext:(BOOL(^)(AFNetworkReachabilityStatus status, BOOL hasNetwork))next
{
    AFNetworkReachabilityManager *networkStatusManager = [AFNetworkReachabilityManager sharedManager];
    @weakify(networkStatusManager);
    [networkStatusManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (next) {
            @strongify(networkStatusManager);
            BOOL hasNetwork = !AFNetworkReachabilityStatusNotReachable;
            BOOL stopMonintoring = next(status, hasNetwork);
            if (stopMonintoring) {
                [networkStatusManager stopMonitoring];
            }
        }
    }];
    [networkStatusManager startMonitoring];
}

- (AFHTTPSessionManager *)hsy_defaultHTTPSessionManager:(BOOL)needTimeoutInterval
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [self hsy_statementHTTPSerializer:kHSYCocoaKitHTTPStatementSerializerJSONRequestSerializerAndJSONResponseSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"image/jpeg", @"text/plain", nil];
    if (needTimeoutInterval) {
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = 60;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
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
