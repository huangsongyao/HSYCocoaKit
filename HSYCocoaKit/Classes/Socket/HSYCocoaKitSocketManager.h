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
FOUNDATION_EXPORT NSString *const HSYCocoaKitSocketNotNetworkStatusNotification;    //无网络通知

@interface HSYCocoaKitSocketManager : NSObject

@property (nonatomic, strong, readonly) RACSubject *delegateSubject;
@property (nonatomic, assign, readonly) kHSYCocoaKitSocketConnectStatus socketConnectStatus;

@property (nonatomic, assign, readonly) uint16_t connectPort;
@property (nonatomic, copy, readonly) NSString *connectHost;

+ (instancetype)shareInstance;
- (void)connectServer:(NSString *)host onPort:(uint16_t)port;
- (void)writeData:(NSData *)data tag:(long)tag;

@end
