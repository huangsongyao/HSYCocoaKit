//
//  HSYCocoaKitSocketManager.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "HSYCocoaKitSocketManager.h"
#import "HSYNetWorkingManager.h"
#import "NSError+Message.h"

#define DEFAULT_SOCKET_CONNECTED_TIMEOUT        20.0f
#define DEFAULT_SOCKET_WRITE_TIME               10.0f

NSString *const HSYCocoaKitSocketConnectStatusNotification = @"HSYCocoaKitSocketConnectStatusNotification";

static NSInteger connectAgainCount = 0;

static HSYCocoaKitSocketManager *socketManager;

@interface HSYCocoaKitSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong, readonly) GCDAsyncSocket *tcpSocket;
@property (nonatomic, strong, readonly) RACSignal *socketDelegateSignal;
@property (nonatomic, strong, readonly) RACSubject *delegateSubject;
@property (nonatomic, strong) NSNumber *observerSockectConnect;
@property (nonatomic, assign) uint16_t hsy_connectPort;
@property (nonatomic, copy) NSString *hsy_connectHost;

@end

@implementation HSYCocoaKitSocketManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socketManager = [HSYCocoaKitSocketManager new];
    });
    return socketManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _delegateSubject = [RACSubject subject];
        _tcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:nil];
        
        //rac下对GCDAsyncSocketDelegate监听
        @weakify(self);
        [[[self.tcpSocket hsy_rac_allSocketDelegateSiganl] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *notification) {
            @strongify(self);
            if (!notification) {
                return;
            }
            GCDAsyncSocket *sock = notification.hsy_tuple.first;
            switch (notification.hsy_rac_delegate) {
                case kHSYCocoaKitSocketRACDelegate_socketConnected: {
                    BOOL connect = [sock isConnected];
                    if (connect) {
                        [self hsy_setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_Connected];
                    }
                }
                    break;
                case kHSYCocoaKitSocketRACDelegate_socketDisconnected: {
                    if (self.socketConnectStatus == kHSYCocoaKitSocketConnectStatus_AccordDisConnected) {
                        return;
                    }
                    if (connectAgainCount <= 3) {
                        connectAgainCount ++;
                        [self hsy_connectServer:sock.connectedHost hsy_onPort:sock.connectedPort];
                        [self hsy_setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_ConnectAgain];
                    } else {
                        connectAgainCount = 0;
                        [self hsy_setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_PassiveDisConnected];
                    }
                }
                    break;
                case kHSYCocoaKitSocketRACDelegate_socketDidReadData: {
                }
                    break;
                case kHSYCocoaKitSocketRACDelegate_socketDidWriteData: {
                    long tag = (long)[notification.hsy_tuple.third longLongValue];
                    //数据发送成功后需要重新设置一次数据的timeout时间
                    [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:DEFAULT_SOCKET_WRITE_TIME tag:tag];
                }
                    break;
                default:
                    break;
            }
            [self.delegateSubject sendNext:notification];
        }];
        
        //监听链接状态的改变，并发送一个外部通知
        [[RACObserve(self, self.observerSockectConnect) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSNumber *connect) {
            kHSYCocoaKitSocketConnectStatus status = (kHSYCocoaKitSocketConnectStatus)[connect integerValue];
            [[NSNotificationCenter defaultCenter] postNotificationName:HSYCocoaKitSocketConnectStatusNotification object:@(status)];
        }];
        [self hsy_setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_UnConnect];
    }
    return self;
}

#pragma mark - Connect && DisConnect

- (RACSignal *)hsy_connectServer:(NSString *)host hsy_onPort:(uint16_t)port
{
    return [self hsy_connectServer:nil hsy_host:host hsy_onPort:port];
}

- (RACSignal *)hsy_connectServer:(NSString *)urlString
{
    return [self hsy_connectServer:urlString hsy_host:nil hsy_onPort:0000];
}

- (RACSignal *)hsy_connectServer:(NSString *)urlString
                        hsy_host:(NSString *)host
                      hsy_onPort:(uint16_t)port
{
    self.hsy_connectHost = host;
    self.hsy_connectPort = port;
    if (urlString) {
        NSURL *url = [NSURL URLWithString:urlString];
        self.hsy_connectHost = url.host;
        self.hsy_connectPort = url.port.longLongValue;
    }
    @weakify(self);
    if (!self.socketDelegateSignal) {
        _socketDelegateSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            if (![self.tcpSocket isConnected]) {
                [self hsy_connect:urlString hsy_host:host hsy_onPort:port hsy_errorBlock:^(NSError *error) {
                    //为了保持订阅信号的活跃性，此处不能使用"- sendError:"，否则订阅信号会被release
                    RACTuple *tuple = RACTuplePack(nil, error);
                    [subscriber sendNext:tuple];
                }];
            }
            [self.delegateSubject subscribeNext:^(id x) {
                //为了保持订阅信号的活跃性，delegateSubject发送"- sendError:"，否则订阅信号会被release，并且delegateSubject只能"- sendNext:"，x返回类型为HSYCocoaKitSocketRACSignal和NSError
                RACTuple *tuple = nil;
                if ([x isKindOfClass:[HSYCocoaKitSocketRACSignal class]]) {
                    HSYCocoaKitSocketRACSignal *notification = (HSYCocoaKitSocketRACSignal *)x;
                    tuple = RACTuplePack(notification, nil);
                } else {
                    NSError *error = (NSError *)x;
                    tuple = RACTuplePack(nil, error);
                }
                [subscriber sendNext:tuple];
            }];
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"必须保持订阅信号的活跃性，socket订阅信号已经被释放，请check订阅信号是否因其他问题被释放或者调用过“- sendError:”、“- sendCompleted”，方法：- connectServer:");
            }];
        }];
    } else if (![self.tcpSocket isConnected]) {
        [self hsy_connect:urlString hsy_host:host hsy_onPort:port hsy_errorBlock:^(NSError *error) {
            @strongify(self);
            [self.delegateSubject sendNext:error];
        }];
    }
    return self.socketDelegateSignal;
}

- (void)hsy_connect:(NSString *)urlString
           hsy_host:(NSString *)host
         hsy_onPort:(uint16_t)port
     hsy_errorBlock:(void(^)(NSError *error))block
{
    @weakify(self);
    [[HSYNetWorkingManager shareInstance] hsy_observer_3x_NetworkReachabilityOfNext:^BOOL(AFNetworkReachabilityStatus status, BOOL hasNetwork) {
        @strongify(self);
        if (!hasNetwork && block) {
            block([NSError hsy_errorWithErrorType:kAFNetworkingStatusErrorTypeNone]);
        } else {
            NSError *error = nil;
            BOOL connect = NO;
            if (urlString.length > 0) {
                connect = [self.tcpSocket connectToUrl:[NSURL URLWithString:urlString]
                                           withTimeout:DEFAULT_SOCKET_CONNECTED_TIMEOUT
                                                 error:&error];
            } else {
                connect = [self.tcpSocket connectToHost:self.hsy_connectHost
                                                 onPort:self.hsy_connectPort
                                            withTimeout:DEFAULT_SOCKET_CONNECTED_TIMEOUT
                                                  error:&error];
            }
            if (error && block) {
                NSLog(@"connect error = %@, connect = %d", error, connect);
                block(error);
            }
        }
        return YES;
    }];
}

- (void)hsy_disConnect
{
    if (self.tcpSocket && [self.tcpSocket isConnected]) {
        [self hsy_setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_AccordDisConnected];
        [self.tcpSocket disconnect];
    }
}

- (void)hsy_setCurrentSocketConnectStatus:(kHSYCocoaKitSocketConnectStatus)statuls
{
    _socketConnectStatus = statuls;
    self.observerSockectConnect = @(self.socketConnectStatus);
}

#pragma mark - Operation

- (void)hsy_writeData:(NSData *)data hsy_tag:(long)tag
{
    [self.tcpSocket writeData:data withTimeout:DEFAULT_SOCKET_WRITE_TIME tag:tag];
}

#pragma mark - Host & Port

- (NSString *)hsy_serverHost
{
    return self.hsy_connectHost;
}

- (uint16_t)hsy_serverPort
{
    return self.hsy_connectPort;
}

@end
