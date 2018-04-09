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
NSString *const HSYCocoaKitSocketNotNetworkStatusNotification = @"HSYCocoaKitSocketNotNetworkStatusNotification";

static NSInteger connectAgainCount = 0;

static HSYCocoaKitSocketManager *socketManager;

@interface HSYCocoaKitSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong, readonly) GCDAsyncSocket *tcpSocket;
@property (nonatomic, strong) NSNumber *observerSockectConnect;

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
        [[[self.tcpSocket rac_allSocketDelegateSiganl] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *notification) {
            @strongify(self);
            if (!notification) {
                return;
            }
            GCDAsyncSocket *sock = notification.tuple.first;
            switch (notification.rac_delegate) {
                case kHSYCocoaKitSocketRACDelegate_socketConnected: {
                    BOOL connect = [sock isConnected];
                    if (connect) {
                        [self setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_Connected];
                    }
                }
                    break;
                case kHSYCocoaKitSocketRACDelegate_socketDisconnected: {
                    NSError *error = notification.tuple.second;
                    if (error) {
                        NSLog(@"- socketDidDisconnect: ==== error = %@", error);
                    }
                    if (self.socketConnectStatus == kHSYCocoaKitSocketConnectStatus_AccordDisConnected) {
                        return;
                    }
                    if (connectAgainCount <= 3) {
                        connectAgainCount ++;
                        [self connectServer:sock.connectedHost onPort:sock.connectedPort];
                        [self setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_ConnectAgain];
                    } else {
                        connectAgainCount = 0;
                        [self setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_PassiveDisConnected];
                    }
                }
                    break;
                case kHSYCocoaKitSocketRACDelegate_socketDidReadData: {
                }
                    break;
                case kHSYCocoaKitSocketRACDelegate_socketDidWriteData: {
                    long tag = [notification.tuple.third longLongValue];
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
        [self setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_UnConnect];
    }
    return self;
}

#pragma mark - Connect && DisConnect

- (void)connectServer:(NSString *)host onPort:(uint16_t)port
{
    _connectHost = host;
    _connectPort = port;
    [[HSYNetWorkingManager shareInstance] observer_3x_NetworkReachabilityOfNext:^BOOL(AFNetworkReachabilityStatus status, BOOL hasNetwork) {
        if (hasNetwork) {
            NSError *error = nil;
            BOOL connect = [self.tcpSocket connectToHost:host
                                                  onPort:port
                                             withTimeout:DEFAULT_SOCKET_CONNECTED_TIMEOUT
                                                   error:&error];
            if (error) {
                NSLog(@"connect error = %@, connect = %d", error, connect);
            }
        } else {
            //无网络状态下发送一个通知，告诉外部
            [[NSNotificationCenter defaultCenter] postNotificationName:HSYCocoaKitSocketNotNetworkStatusNotification object:[NSError errorWithErrorType:kAFNetworkingStatusErrorTypeNone]];
        }
        return YES;
    }];
}

- (void)disConnect
{
    if (self.tcpSocket) {
        [self setCurrentSocketConnectStatus:kHSYCocoaKitSocketConnectStatus_AccordDisConnected];
        [self.tcpSocket disconnect];
    }
}

- (void)setCurrentSocketConnectStatus:(kHSYCocoaKitSocketConnectStatus)statuls
{
    _socketConnectStatus = statuls;
    self.observerSockectConnect = @(self.socketConnectStatus);
}

#pragma mark - Operation

- (void)writeData:(NSData *)data tag:(long)tag
{
    [self.tcpSocket writeData:data withTimeout:DEFAULT_SOCKET_WRITE_TIME tag:tag];
}

@end
