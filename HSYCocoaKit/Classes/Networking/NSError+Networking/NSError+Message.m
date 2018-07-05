//
//  NSError+Message.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "NSError+Message.h"

NSString *const kErrorForNotNetworkKey = @"ErrorForNotNetworkKey";
static const NSInteger kMessageCode = 1991;

@implementation NSError (Message)

+ (NSError *)hsy_errorWithErrorType:(kAFNetworkingStatusErrorType)errorType
{    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    switch (errorType) {
        case kAFNetworkingStatusErrorTypeNone: {
            dic[kErrorForNotNetworkKey] = @"not net work";
        }
            break;
        default:
            break;
    }
    return [[NSError alloc] initWithDomain:@"" code:errorType userInfo:dic];
}

+ (NSError *)hsy_errorWithErrorMessage:(NSString *)message
{
    return [[NSError alloc] initWithDomain:@"" code:kMessageCode userInfo:@{kErrorForNotNetworkKey  : message}];
}

@end
