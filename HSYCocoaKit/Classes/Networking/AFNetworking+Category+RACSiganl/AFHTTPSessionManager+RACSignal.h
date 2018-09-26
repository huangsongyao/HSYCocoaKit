//
//  AFHTTPSessionManager+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/3/30.
//
//

#import <AFNetworking/AFNetworking.h>
#import "ReactiveCocoa.h"
#import "PublicMacroFile.h"

FOUNDATION_EXPORT NSString *const kHSYCocoaKitAFHTTPSessionRequestAllHeaders;   //每次请求成功后通过通知手段返回请求头
FOUNDATION_EXPORT NSString *const kHSYCocoaKitAFHTTPSessionRequestFilters;      //每次response过滤到特殊statusCode会通过通知告知外部，并且截断sendNext动作

typedef NS_ENUM(NSUInteger, kHSYCocoaKitNetworkingRequestModel) {
    
    kHSYCocoaKitNetworkingRequestModel_default  = 0,    //默认占位
    kHSYCocoaKitNetworkingRequestModel_get      = 100,  //get
    kHSYCocoaKitNetworkingRequestModel_post     = 200,  //post
    
};

@interface AFHTTPSessionManager (RACSignal)

#pragma mark - Get

/**
 get请求

 @param urlPath URL的字段
 @param parameters 参数
 @return RACSignal
 */
- (RACSignal *)hsy_rac_getRequest:(NSString *)urlPath parameters:(id)parameters NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 get请求，允许设置额外的请求头信息

 @param urlPath URL的字段
 @param parameters 参数
 @param headers 请求头信息
 @return RACSignal
 */
- (RACSignal *)hsy_rac_getRequest:(NSString *)urlPath parameters:(id)parameters setHeaders:(NSArray<NSDictionary *> *)headers NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

#pragma mark - Post

/**
 post请求

 @param urlPath URL的字段
 @param parameters 参数
 @return RACSignal
 */
- (RACSignal *)hsy_rac_postRequest:(NSString *)urlPath parameters:(id)parameters NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 post请求，允许设置额外的请求头信息

 @param urlPath URL的字段
 @param parameters 参数
 @param headers 请求头信息
 @return RACSignal
 */
- (RACSignal *)hsy_rac_postRequest:(NSString *)urlPath parameters:(id)parameters setHeaders:(NSArray<NSDictionary *> *)headers NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

#pragma mark - Logs

/**
 log台打印error

 @param error error
 */
+ (void)hsy_logRequestError:(NSError *)error;

/**
 log台打印request header

 @param task 任务
 */
+ (void)hsy_logRequestHeaders:(NSURLSessionDataTask *)task;

#pragma mark - HTTPMethod

/**
 根据枚举类型返回GET或者POST的字符串

 @param model 枚举类型
 @return 请求类型
 */
+ (NSString *)hsy_methodFromNetworkingRequestModel:(kHSYCocoaKitNetworkingRequestModel)model;

@end
