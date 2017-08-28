//
//  RACSignal+Timer.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "RACSignal+Timer.h"

static RACSignal *oneMinuteSignal = nil;

@implementation RACSignal (Timer)

+ (RACSignal *)timerSignalOneMinute
{
    return [RACSignal timerSignalOneMinuteForInterval:1.0f];
}

+ (RACSignal *)timerSignalOneMinuteForInterval:(NSTimeInterval)interval
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        oneMinuteSignal = [RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0.1f];
    });
    return oneMinuteSignal;
}

@end
