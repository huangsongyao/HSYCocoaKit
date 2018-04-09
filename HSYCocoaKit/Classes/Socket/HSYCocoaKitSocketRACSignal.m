//
//  HSYCocoaKitSocketRACSignal.m
//  Pods
//
//  Created by huangsongyao on 2018/4/9.
//
//

#import "HSYCocoaKitSocketRACSignal.h"

@implementation HSYCocoaKitSocketRACSignal

- (instancetype)initWithTuple:(RACTuple *)tuple rac_delegateType:(kHSYCocoaKitSocketRACDelegate)type
{
    if (self = [super init]) {
        _tuple = tuple;
        _rac_delegate = type;
    }
    return self;
}

@end
