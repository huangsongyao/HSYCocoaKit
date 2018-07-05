//
//  GCDAsyncSocket+RACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "GCDAsyncSocket+RACSignal.h"
#import "RACDelegateProxy.h"
#import "RACSignal+Operations.h"
#import "NSObject+RACDeallocating.h"
#import "NSObject+RACDescription.h"
#import <objc/runtime.h>

@implementation GCDAsyncSocket (RACSignal)

static void RACUseDelegateProxy(GCDAsyncSocket *self)
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
        proxy = [[RACDelegateProxy alloc] initWithProtocol:@protocol(GCDAsyncSocketDelegate)];
        objc_setAssociatedObject(self, _cmd, proxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return proxy;
}

#pragma mark - Delegate

- (RACSignal *)hsy_rac_socketConnected
{
    RACSignal *signal = [[[[self.rac_delegateProxy
                            signalForSelector:@selector(socket:didConnectToHost:port:)]
                           reduceEach:^(GCDAsyncSocket *socket, NSString *host, NSNumber *port){
                               RACTuple *tuple = RACTuplePack(socket, host, port);
                               HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:kHSYCocoaKitSocketRACDelegate_socketConnected];
                               return racSignal;
    }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - rac_socketConnected", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}

- (RACSignal *)hsy_rac_socketDisconnected
{
    RACSignal *signal = [[[[self.rac_delegateProxy
                            signalForSelector:@selector(socketDidDisconnect:withError:)]
                           reduceEach:^(GCDAsyncSocket *socket, NSError *error){
                               RACTuple *tuple = RACTuplePack(socket, error);
                               HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:kHSYCocoaKitSocketRACDelegate_socketDisconnected];
                               return racSignal;
                           }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - rac_socketDisconnected", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}

- (RACSignal *)hsy_rac_socketDidReadData
{
    RACSignal *signal = [[[[self.rac_delegateProxy
                            signalForSelector:@selector(socket:didReadData:withTag:)]
                           reduceEach:^(GCDAsyncSocket *socket, NSData *data, NSNumber *tag){
                               RACTuple *tuple = RACTuplePack(socket, data, tag);
                               HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:kHSYCocoaKitSocketRACDelegate_socketDidReadData];
                               return racSignal;
                           }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - rac_socketDidReadData", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}

- (RACSignal *)hsy_rac_socketDidWriteData
{
    RACSignal *signal = [[[[self.rac_delegateProxy
                            signalForSelector:@selector(socket:didWriteDataWithTag:)]
                           reduceEach:^(GCDAsyncSocket *socket, NSNumber *tag){
                               RACTuple *tuple = RACTuplePack(socket, tag);
                               HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:kHSYCocoaKitSocketRACDelegate_socketDidWriteData];
                               return racSignal;
                           }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - rac_socketDidWriteData", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}

#pragma mark - All Signal

- (RACSignal *)hsy_rac_allSocketDelegateSiganl
{
    NSArray *racs = @[
                      self.hsy_rac_socketConnected,
                      self.hsy_rac_socketDisconnected,
                      self.hsy_rac_socketDidReadData,
                      self.hsy_rac_socketDidWriteData,
                      ];
    RACSignal *signal = [RACSignal combineLatest:racs reduce:^id(HSYCocoaKitSocketRACSignal *connected, HSYCocoaKitSocketRACSignal *disconnect, HSYCocoaKitSocketRACSignal *readData, HSYCocoaKitSocketRACSignal *writeData){
        HSYCocoaKitSocketRACSignal *notification = [self.class signalForReduce:connected
                                                                    disconnect:disconnect
                                                                      readData:readData
                                                                     writeData:writeData];
        return notification;
    }];
    
    return signal;
}

+ (HSYCocoaKitSocketRACSignal *)signalForReduce:(HSYCocoaKitSocketRACSignal *)connected
                                     disconnect:(HSYCocoaKitSocketRACSignal *)disconnect
                                       readData:(HSYCocoaKitSocketRACSignal *)readData
                                      writeData:(HSYCocoaKitSocketRACSignal *)writeData
{
    if (connected) {
        return connected;
    }
    if (disconnect) {
        return disconnect;
    }
    if (readData) {
        return readData;
    }
    if (writeData) {
        return writeData;
    }
    return nil;
}

@end

