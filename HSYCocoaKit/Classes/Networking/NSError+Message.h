//
//  NSError+Message.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const kErrorForNotNetworkKey;

typedef NS_ENUM(NSUInteger, kAFNetworkingStatusErrorType) {
    
    kAFNetworkingStatusErrorTypeNone    = 0,        //无网络状态
};

@interface NSError (Message)

/**
 *  转换错误码为提示字典的error
 *
 *  @param errorType 错误码类型
 *
 *  @return NSError对象
 */
+ (NSError *)errorWithErrorType:(kAFNetworkingStatusErrorType)errorType;

/**
 *  转换错误信息为提示的error
 *
 *  @param message 提示信息
 *
 *  @return NSError对象
 */
+ (NSError *)errorWithErrorMessage:(NSString *)message;

@end
