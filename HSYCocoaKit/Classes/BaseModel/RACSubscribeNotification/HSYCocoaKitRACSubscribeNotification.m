//
//  HSYCocoaKitRACSubscribeNotification.m
//  Pods
//
//  Created by huangsongyao on 2018/4/8.
//
//

#import "HSYCocoaKitRACSubscribeNotification.h"

@implementation HSYCocoaKitRACSubscribeNotification

- (instancetype)initWithSubscribeNotificationType:(kHSYCocoaKitRACSubjectOfNextType)type subscribeContents:(NSArray<id> *)contents
{
    if (self = [super init]) {
        _subscribeType = type;
        _subscribeContents = contents;
        _hsy_isFirstRequest = NO;
    }
    return self;
}

@end
