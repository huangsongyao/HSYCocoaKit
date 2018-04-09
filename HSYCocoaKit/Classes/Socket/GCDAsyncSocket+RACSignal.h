//
//  GCDAsyncSocket+RACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "GCDAsyncSocket.h"
#import "HSYCocoaKitSocketRACSignal.h"

@class RACDelegateProxy;
@interface GCDAsyncSocket (RACSignal)

@property (nonatomic, strong, readonly) RACDelegateProxy *rac_delegateProxy;

- (RACSignal *)rac_socketConnected;         //连接成功
- (RACSignal *)rac_socketDisconnected;      //连接断开
- (RACSignal *)rac_socketDidReadData;       //接收到Socket服务器的数据
- (RACSignal *)rac_socketDidWriteData;      //发送数据成功

- (RACSignal *)rac_allSocketDelegateSiganl; //合并所有信号

@end
