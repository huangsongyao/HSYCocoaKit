//
//  GCDAsyncSocket+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "GCDAsyncSocket.h"
#import "HSYCocoaKitSocketRACSignal.h"
#import "PublicMacroFile.h"

@class RACDelegateProxy;
@interface GCDAsyncSocket (RACSignal)

@property (nonatomic, strong, readonly) RACDelegateProxy *rac_delegateProxy;

- (RACSignal *)hsy_rac_socketConnected NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);         //连接成功
- (RACSignal *)hsy_rac_socketDisconnected NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);      //连接断开
- (RACSignal *)hsy_rac_socketDidReadData NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);       //接收到Socket服务器的数据
- (RACSignal *)hsy_rac_socketDidWriteData NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);      //发送数据成功

- (RACSignal *)hsy_rac_allSocketDelegateSiganl NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8); //合并所有信号

@end
