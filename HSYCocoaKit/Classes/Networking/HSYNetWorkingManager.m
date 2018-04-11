//
//  HSYNetWorkingManager.m
//  Pods
//
//  Created by huangsongyao on 2018/4/2.
//
//

#import "HSYNetWorkingManager.h"
#import "NetworkingRequestPathFile.h"
#import "NSError+Message.h"

static NSString *kHSYValueKey  = @"HSYValueKey";

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
        _httpSessionManager = [HSYNetWorkingManager hsy_defaultHTTPSessionManager:YES];
        _fileSessionManager = [HSYNetWorkingManager hsy_defaultURLSessionManager];
    }
    return self;
}

+ (NSString *)hsy_urlFromPath:(NSString *)path
{
    if ([path hasPrefix:@"http"]) {
        return path;
    }
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", BASE_URL, path];
    if (![urlString containsString:@"http"]) {
        NSLog(@"链接不含有http字符串！链接不完整！");
        return nil;
    }
    return urlString;
}

+ (NSArray<NSDictionary *> *)hsy_defaultHeaders
{
    return @[
             ];
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

+ (AFHTTPSessionManager *)hsy_defaultHTTPSessionManager:(BOOL)needTimeoutInterval
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];   //申明请求参数为json格式
    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //申明回调数据为json格式
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"image/jpeg", @"text/plain", nil];
    if (needTimeoutInterval) {
        [manager.requestSerializer willChangeValueForKey:@"WillChangeToRequestTimeOutInterval"];
        manager.requestSerializer.timeoutInterval = 60.0f;
        [manager.requestSerializer didChangeValueForKey:@"DidChangeToRequestTimeOutInterval"];
    }
    for (NSDictionary *dic in self.class.hsy_defaultHeaders) {
        [manager.requestSerializer setValue:dic.allValues.firstObject forHTTPHeaderField:dic.allKeys.firstObject];
    }
    return manager;
}

+ (AFURLSessionManager *)hsy_defaultURLSessionManager
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

@end
