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
                               NSLog(@"\n socket connected! host = %@, port = %@", host, port);
                               return racSignal;
    }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - rac_socketConnected", self.rac_description];
    
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
                               NSLog(@"\n socket did write data! tag = %@", tag);
                               return racSignal;
                           }] takeUntil:self.rac_willDeallocSignal]
                         setNameWithFormat:@"%@ - rac_socketDidWriteData", self.rac_description];
    
    RACUseDelegateProxy(self);
    return signal;
}


@end

