//
//  NetWorkingManager.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NetWorkingManager : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *httpSessionManager;             //>=3.0f version

+ (instancetype)shareInstance;

/**
 *  监听当前网络状态
 *
 *  @return 网络状态的信号
 */
- (RACSignal *)networking_3x_Reachability;

/**
 通过字段拼接完整的url，若字段中含有http开头字眼，则默认为是一个完整的链接

 @param path 字段
 @return 请求地址
 */
+ (NSString *)urlFromPath:(NSString *)path;

/**
 网络监听

 @param next 网络状态回调，如果需要持续对网络状态进行监听，则在block中返回NO
 */
- (void)observer_3x_NetworkReachabilityOfNext:(BOOL(^)(AFNetworkReachabilityStatus status, BOOL hasNetwork))next;

@end