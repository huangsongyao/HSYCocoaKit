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

typedef NS_ENUM(NSUInteger, kHSYCocoaKitSocketRACDelegate) {
    
    kHSYCocoaKitSocketRACDelegate_socketConnected           = 1910,     //连接成功
    kHSYCocoaKitSocketRACDelegate_socketDisconnected        = 1920,     //连接断开
    kHSYCocoaKitSocketRACDelegate_socketDidReadData         = 1930,     //读取数据
    kHSYCocoaKitSocketRACDelegate_socketDidWriteData        = 1940,     //发送数据成功
    
};

@interface HSYCocoaKitSocketRACSignal : NSObject

@property (nonatomic, strong) RACTuple *hsy_tuple;
@property (nonatomic, assign) kHSYCocoaKitSocketRACDelegate hsy_rac_delegate;

- (instancetype)initWithTuple:(RACTuple *)tuple rac_delegateType:(kHSYCocoaKitSocketRACDelegate)type;

/**
 json字符串转data

 @param jsonString json字符串
 @return data
 */
+ (NSData *)hsy_writeData:(NSString *)jsonString;

/**
 将tuple中的data转json

 @return json
 */
- (id)hsy_toJSONReponse;

/**
 将字典转为json格式的data，用于socket丢包
 
 @return json格式的data
 */
+ (NSData *)toJSONData:(NSDictionary *)dictionary;

@end
