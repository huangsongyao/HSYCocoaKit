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

+ (NSData *)hsy_writeData:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return data;
}

- (id)hsy_toJSONReponse
{
    id second = self.tuple.second;
    if ([second isKindOfClass:[NSData class]]) {
        NSData *data = (NSData *)second;
        id json = [NSObject toJSONObject:data];
        return json;
    }
    return nil;
}

@end
