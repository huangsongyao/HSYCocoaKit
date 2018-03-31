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

+ (NSError *)errorWithErrorType:(kAFNetworkingStatusErrorType)errorType
{    
    NSDictionary *dic = nil;
    
    switch (errorType) {
        case kAFNetworkingStatusErrorTypeNone: {
            
        }
            break;
            
        default:
            break;
    }
    
    return [[NSError alloc] initWithDomain:@"" code:errorType userInfo:dic];
}

+ (NSError *)errorWithErrorMessage:(NSString *)message
{
    return [[NSError alloc] initWithDomain:@"" code:kMessageCode userInfo:@{kErrorForNotNetworkKey : message}];
}

@end
