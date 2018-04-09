//
//  HSYCocoaKitSocketManager.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "GCDAsyncSocket+RACSignal.h"

FOUNDATION_EXPORT NSString *const HSYCocoaKitSocketConnectStatusNotification;       //socketConnectStatus通知

@interface HSYCocoaKitSocketManager : NSObject

@property (nonatomic, assign, readonly) kHSYCocoaKitSocketConnectStatus socketConnectStatus;
@property (nonatomic, assign, readonly) uint16_t connectPort;
@property (nonatomic, copy, readonly) NSString *connectHost;

+ (instancetype)shareInstance;

/**
 建立socket长连接，订阅信号的回调类型为RACTuple实例，first表示HSYCocoaKitSocketRACSignal，second表示NSError

 @param host ip地址
 @param port 端口
 @return RACSignal信号
 */
- (RACSignal *)connectServer:(NSString *)host onPort:(uint16_t)port;

/**
 建立socket长连接，订阅信号的回调类型为RACTuple实例，first表示HSYCocoaKitSocketRACSignal，second表示NSError

 @param urlString socket长连接的地址
 @return RACSignal信号
 */
- (RACSignal *)connectServer:(NSString *)urlString;

/**
 向socket服务器丢包

 @param data data数据
 @param tag tag
 */
- (void)writeData:(NSData *)data tag:(long)tag;


@end
