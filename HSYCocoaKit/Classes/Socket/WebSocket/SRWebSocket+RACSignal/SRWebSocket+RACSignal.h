//
//  SRWebSocket+RACSignal.h
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/12.
//

#import "SocketRocket.h"
#import "HSYCocoaKitSocketRACSignal.h"
#import "PublicMacroFile.h"

@class RACDelegateProxy;
@interface SRWebSocket (RACSignal)

@property (nonatomic, strong, readonly) RACDelegateProxy *rac_delegateProxy;

- (RACSignal *)hsy_rac_webSocketConnected;
- (RACSignal *)hsy_rac_webSocketDidReceivePong;

@end
