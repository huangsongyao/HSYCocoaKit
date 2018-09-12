//
//  SRWebSocket+RACSignal.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/12.
//

#import "SRWebSocket+RACSignal.h"
#import "RACDelegateProxy.h"
#import "RACSignal+Operations.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"
#import <objc/runtime.h>

@implementation SRWebSocket (RACSignal)

static void RACUseDelegateProxy(SRWebSocket *self)
{
    if (self.delegate == self.rac_delegateProxy) {
        return;
    }
    self.rac_delegateProxy.rac_proxiedDelegate = self.delegate;
    self.delegate = (id)self.rac_delegateProxy;
}

- (RACDelegateProxy *)rac_delegateProxy
{
    RACDelegateProxy *proxy = objc_getAssociatedObject(self, _cmd);
    if (proxy == nil) {
        proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(SRWebSocketDelegate)];
        objc_setAssociatedObject(self, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return proxy;
}

#pragma mark - Delegate

- (RACSignal *)hsy_rac_webSocketDidOpen
{
    RACSignal *signal = [[[[self.rac_delegateProxy
                            signalForSelector:@selector(webSocketDidOpen:)]
                           reduceEach:^(SRWebSocket *webSocket){
                               RACTuple *tuple = RACTuplePack(webSocket);
                               HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:kHSYCocoaKitSocketRACDelegate_socketConnected];
                               NSLog(@"\n==============================================================");
                               NSLog(@"\n webSocket connected! webSocket = %@", webSocket);
                               NSLog(@"=============================================================\n ");
                               return racSignal;
                           }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - hsy_rac_webSocketDidOpen", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}

- (RACSignal *)hsy_rac_webSocketOpenFail
{
    RACSignal *signal = [[[[self.rac_delegateProxy
                            signalForSelector:@selector(webSocket:didFailWithError:)]
                           reduceEach:^(SRWebSocket *webSocket, NSError *error){
                               RACTuple *tuple = RACTuplePack(webSocket, error);
                               HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:kHSYCocoaKitSocketRACDelegate_WebSocketConnectFailure];
                               NSLog(@"\n==============================================================");
                               NSLog(@"\n webSocket connect Failure! webSocket = %@, error = %@", webSocket, error);
                               NSLog(@"=============================================================\n ");
                               return racSignal;
                           }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - hsy_rac_webSocketOpenFail", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}

- (RACSignal *)hsy_rac_webSocketConnected
{
    return [self.hsy_rac_webSocketDidOpen merge:self.hsy_rac_webSocketOpenFail];
}

- (RACSignal *)hsy_rac_webSocketDidReceivePong
{
    RACSignal *signal = [[[[self.rac_delegateProxy
                            signalForSelector:@selector(webSocket:didReceivePong:)]
                           reduceEach:^(SRWebSocket *webSocket, NSData *pongPayload){
                               RACTuple *tuple = RACTuplePack(webSocket, pongPayload);
                               HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:kHSYCocoaKitSocketRACDelegate_socketDidWriteData];
                               NSLog(@"\n==============================================================");
                               NSLog(@"\n webSocket did receive pong! webSocket = %@, pongPayload = %@", webSocket, pongPayload);
                               NSLog(@"=============================================================\n ");
                               return racSignal;
                           }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - hsy_rac_webSocketDidReceivePong", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}

@end
