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

/**
 截取socket连接成功后的委托回调信号
 */
- (RACSignal *)hsy_rac_socketConnected NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

/**
 截取socket连接成功后的“app wirte to server”的信号
 */
- (RACSignal *)hsy_rac_socketDidWriteData NS_AVAILABLE_IOS(HSY_AVAILABLE_IOS_8);

@end
