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

@interface HSYNetWorkingManager : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *httpSessionManager NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);                //>=3.0f version，一般网络请求
@property (nonatomic, strong, readonly) AFURLSessionManager *fileSessionManager NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);                //>=3.0f version，文件上传或者下载请求

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
 设置默认的请求头，在本类中返回了一个@[]空的数组，如需设置默认的请求头，请继承本类，在子类中重写“+ hsy_defaultHeaders”方法，并返回需要设置的，格式为：@[@{@"请求头字段1" : @"字段1对应的value"}, @{@"请求头字段2" : @"字段2对应的value"}, ...]

 @return 请求头的默认设置集合
 */
+ (NSArray<NSDictionary *> *)hsy_defaultHeaders;

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

@end
