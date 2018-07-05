//
//  HSYNetWorkingManager.h
//  Pods
//
//  Created by huangsongyao on 2018/4/2.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ReactiveCocoa.h"
#import "AFURLSessionManager+RACSignal.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitHTTPStatementSerializer) {
    
    //request声明为[AFHTTPRequestSerializer serializer]格式，response声明为[AFHTTPResponseSerializer serializer]格式
    kHSYCocoaKitHTTPStatementSerializerHTTPRequestSerializerAndHTTPResponseSerializer   = 1024,
    //request声明为[AFHTTPResponseSerializer serializer]格式，response声明为[AFJSONResponseSerializer serializer]格式
    kHSYCocoaKitHTTPStatementSerializerHTTPRequestSerializerAndJSONResponseSerializer,
    //request声明为[AFJSONRequestSerializer serializer]格式，response声明为[AFHTTPResponseSerializer serializer]格式
    kHSYCocoaKitHTTPStatementSerializerJSONRequestSerializerAndHTTPResponseSerializer,
    //request声明为[AFJSONRequestSerializer serializer]格式，response声明为[AFJSONResponseSerializer serializer]格式
    kHSYCocoaKitHTTPStatementSerializerJSONRequestSerializerAndJSONResponseSerializer,
};

@interface HSYNetWorkingManager : NSObject

/**
 >=3.0f version，一般网络请求，默认已声明为requestSerializer和responseSerializer声明为[AFJSONRequestSerializer serializer]和[AFJSONResponseSerializer serializer]，如不需要声明，则在子类中冲定义requestSerializer为[AFHTTPRequestSerializer serializer]或responseSerializer为[AFHTTPResponseSerializer serializer]
 */
@property (nonatomic, strong, readonly) AFHTTPSessionManager *httpSessionManager NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 >=3.0f version，文件上传或者下载请求，默认已声明为responseSerializer声明为[AFJSONResponseSerializer serializer]，如不需要声明，则在子类中冲定义responseSerializer为[AFHTTPResponseSerializer serializer]
 */
@property (nonatomic, strong, readonly) AFURLSessionManager *fileSessionManager NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 单例

 @return 单例
 */
+ (instancetype)shareInstance;

/**
 设置默认的请求地址域名，如果没有执行本方法，则默认域名为nil，详细可见建言断点

 @param baseUrl 域名地址
 */
- (void)hsy_setNetworkBaseUrl:(NSString *)baseUrl;

/**
 *  监听当前网络状态，检测结果为有网时发送completed信号，并结束，不会返回当前网络状态，如果需要获取具体网络状态，请使用“- observer_3x_NetworkReachabilityOfNext:”方法
 *
 *  @return 网络状态的信号，有网络返回completed信号，无则返回error信号
 */
- (RACSignal *)hsy_networking_3x_Reachability NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 通过字段拼接完整的url，若字段中含有http开头字眼，则默认为是一个完整的链接
 
 @param path 字段
 @return 请求地址
 */
+ (NSString *)hsy_urlFromPath:(NSString *)path;

/**
 网络监听，有无网络均会从next的block进行回调，并且，允许设置该网络监听是否持续存在
 
 @param next 网络状态回调，如果需要持续对网络状态进行监听，则在block中返回NO
 */
- (void)hsy_observer_3x_NetworkReachabilityOfNext:(BOOL(^)(AFNetworkReachabilityStatus status, BOOL hasNetwork))next NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 允许设置request和response的格式，http或者json

 @param serializer kHSYCocoaKitHTTPStatementSerializer枚举
 */
- (void)hsy_statementHTTPSerializer:(kHSYCocoaKitHTTPStatementSerializer)serializer;

/**
 提供接口允许设置request请求头

 @param headers 请求头的集合，格式为@[@{@"请求头字段A" : @"请求头字段A的内容的value"}, @{@"请求头字段B" : @"请求头字段B的内容的value"}, ...]
 */
- (void)hsy_setHTTPSessionHeaders:(NSArray<NSDictionary *> *)headers;

@end
