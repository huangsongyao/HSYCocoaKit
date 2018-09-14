//
//  HSYCocoaKitWebSocketManager.m
//  HSYCocoaKit
//
//  Created by huangsongyao on 2018/9/12.
//

#import "HSYCocoaKitWebSocketManager.h"
#import "SocketRocket.h"
#import "ReactiveCocoa.h"
#import "HSYNetWorkingManager.h"
#import "NSError+Message.h"

NSString *const kHSYCocoaKitWebSocketDidReceiveMessageNotification      = @"HSYCocoaKitWebSocketDidReceiveMessageNotification";
NSString *const kHSYCocoaKitWebSocketDisconnectedNotification           = @"HSYCocoaKitWebSocketDisconnectedNotification";

static HSYCocoaKitWebSocketManager *weSocketManager;

@interface HSYCocoaKitWebSocketManager () <SRWebSocketDelegate>

@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic, strong, readonly) NSURLRequest *socketURLRequest;
@property (nonatomic, copy) void(^webSocketDidReceiveMessage)(RACTuple *tuple);

@end

@implementation HSYCocoaKitWebSocketManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weSocketManager = [[HSYCocoaKitWebSocketManager alloc] init];
    });
    return weSocketManager;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.webSocketDidReceiveMessage = ^(RACTuple *tuple) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHSYCocoaKitWebSocketDidReceiveMessageNotification object:tuple];
        };
    }
    return self;
}

- (RACSignal *)hsy_webSocketConnect:(NSString *)urlString
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[HSYNetWorkingManager shareInstance] hsy_observer_3x_NetworkReachabilityOfNext:^BOOL(AFNetworkReachabilityStatus status, BOOL hasNetwork) {
            @strongify(self);
            if (!hasNetwork) {
                [subscriber sendError:[NSError hsy_errorWithErrorType:kAFNetworkingStatusErrorTypeNone]];
            } else {
                NSURL *url = [NSURL URLWithString:urlString];
                self->_socketURLRequest = [NSURLRequest requestWithURL:url];
                self.webSocket = [[SRWebSocket alloc] initWithURLRequest:self.socketURLRequest];
                self.webSocket.delegate = self;
                [self.webSocket open];
                [[[self.webSocket hsy_rac_webSocketConnected] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *notification) {
                    self->_isConnected = (notification.hsy_rac_delegate == kHSYCocoaKitSocketRACDelegate_socketConnected);
                    [subscriber sendNext:notification];
                    [subscriber sendCompleted];
                }];
            }
            return NO;
        }];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_webSocketConnect:” in %@ class", NSStringFromClass(self.class));
        }];
    }];
    
}

- (RACSignal *)hsy_webSocketSendPing:(NSData *)pingData
{
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        if (!self.isConnected) {
            [subscriber sendError:[NSError hsy_errorWithErrorType:kAFNetworkingStatusErrorTypeNone]];
        } else {
            [self.webSocket sendPing:pingData];
            [[[self.webSocket hsy_rac_webSocketDidReceivePong] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(HSYCocoaKitSocketRACSignal *notification) {
                [subscriber sendNext:notification];
                [subscriber sendCompleted];
            }];
        }
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"release methods “- hsy_webSocketSendPing:” in %@ class", NSStringFromClass(self.class));
        }];
    }];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
{
    //webSocket收到消息
    if (self.webSocketDidReceiveMessage) {
        RACTuple *tuple = RACTuplePack(message);
        self.webSocketDidReceiveMessage(tuple);
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean
{
    //webSocket链接断开
    NSLog(@"\n========================================================");
    NSLog(@"\n webSocket disconnected! errorCode = %@, reason = %@, wasClean = %@", @(code), reason, @(wasClean));
    NSLog(@"========================================================\n");
    _isConnected = NO;
    RACTuple *tuple = RACTuplePack(webSocket, @(code), reason, @(wasClean));
    [[NSNotificationCenter defaultCenter] postNotificationName:kHSYCocoaKitWebSocketDisconnectedNotification object:tuple];
}

@end
