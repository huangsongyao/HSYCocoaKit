//
//  HSYCocoaKitSocketManager.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket+RACSignal.h"

FOUNDATION_EXPORT NSString *const kHSYCocoaKitSocketDidReadDataNotification;        //接收到server to app的信号
FOUNDATION_EXPORT NSString *const kHSYCocoaKitSocketDisconnectedNotification;       //socket disconnect

@interface HSYCocoaKitSocketManager : NSObject

@property (nonatomic, assign, readonly) kHSYCocoaKitSocketRACDelegate socketConnectStatus;

+ (instancetype)shareInstance;

/**
 建立socket长连接

 @param host ip地址
 @param port 端口
 @return RACSignal信号
 */
- (RACSignal *)hsy_connectServer:(NSString *)host hsy_onPort:(uint16_t)port NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 建立socket长连接

 @param urlString socket长连接的地址
 @return RACSignal信号
 */
- (RACSignal *)hsy_connectServer:(NSString *)urlString NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 断开socket长连接
 */
- (void)hsy_disConnect;

/**
 向socket服务器丢包

 @param data data数据
 @param tag tag
 @return RACSignal信号
 */
- (RACSignal *)hsy_writeData:(NSData *)data hsy_tag:(long)tag NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

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
