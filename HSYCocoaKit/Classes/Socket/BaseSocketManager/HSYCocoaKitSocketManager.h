//
//  HSYCocoaKitSocketManager.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket+RACSignal.h"
#import "GCDAsyncSocket.h"

FOUNDATION_EXPORT NSString *const HSYCocoaKitSocketConnectStatusNotification;       //socketConnectStatus通知

@interface HSYCocoaKitSocketManager : NSObject

@property (nonatomic, assign, readonly) kHSYCocoaKitSocketConnectStatus socketConnectStatus;

+ (instancetype)shareInstance;

/**
 建立socket长连接，订阅信号的回调类型为RACTuple实例，first表示HSYCocoaKitSocketRACSignal，second表示NSError

 @param host ip地址
 @param port 端口
 @return RACSignal信号
 */
- (RACSignal *)hsy_connectServer:(NSString *)host hsy_onPort:(uint16_t)port NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 建立socket长连接，订阅信号的回调类型为RACTuple实例，first表示HSYCocoaKitSocketRACSignal，second表示NSError

 @param urlString socket长连接的地址
 @return RACSignal信号
 */
- (RACSignal *)hsy_connectServer:(NSString *)urlString NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 向socket服务器丢包

 @param data data数据
 @param tag tag
 */
- (void)hsy_writeData:(NSData *)data hsy_tag:(long)tag NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 当前链接的socket的ip

 @return ip
 */
- (NSString *)hsy_serverHost NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 当前链接的socket的端口

 @return 端口
 */
- (uint16_t)hsy_serverPort NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
