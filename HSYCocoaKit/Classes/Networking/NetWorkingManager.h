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
#import "AFHTTPRequestOperationManager+RACSignal.h"

@interface NetWorkingManager : NSObject

@property (nonatomic, strong) AFHTTPRequestOperationManager *httpManager;           //post request管理者
@property (nonatomic, assign, readonly) AFNetworkReachabilityStatus isReachable;    //网络状态

+ (instancetype)shareInstance;

/**
 *  监听当前网络状态
 *
 *  @return 网络状态的信号
 */
- (RACSignal *)getNetworkingReachability;

@end
