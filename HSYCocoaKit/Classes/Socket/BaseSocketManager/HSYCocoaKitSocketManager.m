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
#import "GCDAsyncSocket.h"
#import "NSObject+JSONObjc.h"

NSString *const kHSYCocoaKitSocketDidReadDataNotification   = @"HSYCocoaKitSocketDidReadDataNotification";
NSString *const kHSYCocoaKitSocketDisconnectedNotification  = @"HSYCocoaKitSocketDisconnectedNotification";

static HSYCocoaKitSocketManager *socketManager;

@interface HSYCocoaKitSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket *tcpSocket;
@property (nonatomic, strong) RACSubject *hsy_subject;
@property (nonatomic, assign) uint16_t hsy_connectPort;
@property (nonatomic, copy) NSString *hsy_connectHost;

@end

@implementation HSYCocoaKitSocketManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socketManager = [[HSYCocoaKitSocketManager alloc] init];
    });
    return socketManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        self.tcpSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:mainQueue];
        self.hsy_subject = [RACSubject subject];
        
        @weakify(self);
        [[self.hsy_subject deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
            @strongify(self);
            GCDAsyncSocket *sock = (GCDAsyncSocket *)tuple.first;
            NSDictionary *param = @{@(YES) : @{@(kHSYCocoaKitSocketRACDelegate_socketDidReadData) : kHSYCocoaKitSocketDidReadDataNotification, }, @(NO) : @{@(kHSYCocoaKitSocketRACDelegate_socketDisconnected) : kHSYCocoaKitSocketDisconnectedNotification, }, }[@(sock.isConnected)];
            HSYCocoaKitSocketRACSignal *racSignal = [[HSYCocoaKitSocketRACSignal alloc] initWithTuple:tuple rac_delegateType:(kHSYCocoaKitSocketRACDelegate)[param.allKeys.firstObject integerValue]];
            [self hsy_observerNotification:racSignal];
            [[NSNotificationCenter defaultCenter] postNotificationName:param.allValues.firstObject object:tuple];
        }];
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
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        if (!self.tcpSocket.isConnected) {
            [[HSYNetWorkingManager shareInstance] hsy_observer_3x_NetworkReachabilityOfNext:^BOOL(AFNetworkReachabilityStatus status, BOOL hasNetwork) {
                if (!hasNetwork) {
                    [subscriber sendError:[NSError hsy_errorWithErrorType:kAFNetworkingStatusErrorTypeNone]];
                } else {
                    NSError *error = nil;
                    BOOL connect = [self.tcpSocket connectToHost:self.hsy_connectHost
                                                          onPort:self.hsy_connectPort
                                                     withTimeout:-1
                                                           error:&error];
                    if (error) {
                        NSLog(@"\n connect error = %@, connect = %d", error, connect);
                        [subscriber sendError:error];
                    } else {
                        NSLog(@"\n connected socket server result = %d, please hold seconds waiting for “HSYCocoaKitSocketConnectStatusNotification” notification !!", connect);
                        [[[self.tcpSocket hsy_rac_socketConnected] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *notification) {
                            @strongify(self);
                            [self hsy_observerNotification:notification];
                            [subscriber sendNext:notification];
                            [subscriber sendCompleted];
                        }];
                    }
                }
                return NO;
            }];
        }
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_connectServer:hsy_host:hsy_onPort:”");
        }];
    }];
}

- (void)hsy_disConnect
{
    [self.tcpSocket disconnect];
}

#pragma mark - Operation

- (RACSignal *)hsy_writeData:(NSData *)data hsy_tag:(long)tag
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        [self.tcpSocket writeData:data withTimeout:-1 tag:tag];
        [[[self.tcpSocket hsy_rac_socketDidWriteData] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *notification) {
            @strongify(self);
            [self hsy_observerNotification:notification];
            [[self.hsy_subject deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(RACTuple *tuple) {
                [subscriber sendNext:tuple];
                [subscriber sendCompleted];
            }];
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_writeData:hsy_tag:” in %@ class", NSStringFromClass(self.class));
        }];
    }];
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

#pragma mark - Cool Signal For GCDAsyncSocketDelegate

- (void)hsy_observerNotification:(HSYCocoaKitSocketRACSignal *)notification
{
    GCDAsyncSocket *sock = notification.hsy_tuple.first;
    kHSYCocoaKitSocketRACDelegate status = notification.hsy_rac_delegate;
    _socketConnectStatus = status;
    if (status == kHSYCocoaKitSocketRACDelegate_socketDidWriteData) {
        //数据发送后要开始读取
        long tag = (long)[notification.hsy_tuple.third longLongValue];
        [sock readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:tag];
    }
}

#pragma mark - GCDAsyncSocketDelegate

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSDictionary *result = [NSString toJSONObject:data];
    NSLog(@"\n========================================================");
    NSLog(@"\n socket did read data! data = %@, tag = %@", result, @(tag));
    NSLog(@"\n========================================================");
    RACTuple *tuple = RACTuplePack(sock, result, data, @(tag));
    [self.hsy_subject sendNext:tuple];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
    NSLog(@"\n========================================================");
    NSLog(@"\n socket disconnected! error = %@", err);
    NSLog(@"\n========================================================");
    RACTuple *tuple = RACTuplePack(sock, err);
    [self.hsy_subject sendNext:tuple];
}

@end
