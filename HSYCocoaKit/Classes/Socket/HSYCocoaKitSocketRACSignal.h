//
//  HSYCocoaKitSocketRACSignal.h
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "NSObject+JSONObjc.h"

typedef NS_ENUM(NSUInteger, kHSYCocoaKitSocketConnectStatus) {
    
    kHSYCocoaKitSocketConnectStatus_UnConnect               = 988,      //尚未连接
    kHSYCocoaKitSocketConnectStatus_Connected               = 998,      //已连接
    kHSYCocoaKitSocketConnectStatus_PassiveDisConnected     = 1098,     //被动断开
    kHSYCocoaKitSocketConnectStatus_AccordDisConnected      = 1198,     //主动断开
    kHSYCocoaKitSocketConnectStatus_ConnectAgain            = 1298,     //重连中
};

typedef NS_ENUM(NSUInteger, kHSYCocoaKitSocketRACDelegate) {
    
    kHSYCocoaKitSocketRACDelegate_socketConnected           = 1910,     //连接成功
    kHSYCocoaKitSocketRACDelegate_socketDisconnected        = 1920,     //连接断开
    kHSYCocoaKitSocketRACDelegate_socketDidReadData         = 1930,     //读取数据
    kHSYCocoaKitSocketRACDelegate_socketDidWriteData        = 1940,     //发送数据成功
    
};

@interface HSYCocoaKitSocketRACSignal : NSObject

@property (nonatomic, strong, readonly) RACTuple *tuple;
@property (nonatomic, assign, readonly) kHSYCocoaKitSocketRACDelegate rac_delegate;

- (instancetype)initWithTuple:(RACTuple *)tuple rac_delegateType:(kHSYCocoaKitSocketRACDelegate)type;

/**
 json字符串转data

 @param jsonString json字符串
 @return data
 */
+ (NSData *)writeData:(NSString *)jsonString;

/**
 将tuple中的data转json

 @return json
 */
- (id)toJSONReponse;

@end
