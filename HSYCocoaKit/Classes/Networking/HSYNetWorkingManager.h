//
//  HSYNetWorkingManager.h
//  Pods
//
//  Created by huangsongyao on 2018/4/2.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "AFURLSessionManager+RACSignal.h"

@interface HSYNetWorkingManager : NSObject

@property (nonatomic, strong, readonly) AFHTTPSessionManager *httpSessionManager;               //>=3.0f version，一般网络请求
@property (nonatomic, strong, readonly) AFURLSessionManager *fileSessionManager;                //>=3.0f version，文件上传或者下载请求

+ (instancetype)shareInstance;

/**
 *  监听当前网络状态，检测结果为有网时发送completed信号，并结束，不会返回当前网络状态，如果需要获取具体网络状态，请使用“- observer_3x_NetworkReachabilityOfNext:”方法
 *
 *  @return 网络状态的信号，有网络返回completed信号，无则返回error信号
 */
- (RACSignal *)networking_3x_Reachability;

/**
 通过字段拼接完整的url，若字段中含有http开头字眼，则默认为是一个完整的链接
 
 @param path 字段
 @return 请求地址
 */
+ (NSString *)urlFromPath:(NSString *)path;

/**
 网络监听，有无网络均会从next的block进行回调，并且，允许设置该网络监听是否持续存在
 
 @param next 网络状态回调，如果需要持续对网络状态进行监听，则在block中返回NO
 */
- (void)observer_3x_NetworkReachabilityOfNext:(BOOL(^)(AFNetworkReachabilityStatus status, BOOL hasNetwork))next;

@end
