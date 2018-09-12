//
//  HSYCocoaKitWebSocketManager.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/12.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket+RACSignal.h"

FOUNDATION_EXPORT NSString *const kHSYCocoaKitWebSocketDidReceiveMessageNotification;           //收到webSocket to app的消息
FOUNDATION_EXPORT NSString *const kHSYCocoaKitWebSocketDisconnectedNotification;                //webSocket disconnect

@interface HSYCocoaKitWebSocketManager : NSObject

@property (nonatomic, assign, readonly) BOOL isConnected;

+ (instancetype)shareInstance;

/**
 建立webSocket长连接
 
 @param urlString webSocket远端地址
 @return RACSignal信号
 */
- (RACSignal *)hsy_webSocketConnect:(NSString *)urlString;

/**
 webSocket发送消息
 
 @param pingData 和服务器约定好的json格式类型
 @return RACSignal信号
 */
- (RACSignal *)hsy_webSocketSendPing:(NSData *)pingData;

@end
