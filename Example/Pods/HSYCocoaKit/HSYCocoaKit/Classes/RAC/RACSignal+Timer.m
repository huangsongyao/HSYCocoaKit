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

+ (RACSignal *)rac_timerSignalOneMinute
{
    return [RACSignal rac_timerSignalOneMinuteForInterval:1.0f];
}

+ (RACSignal *)rac_timerSignalOneMinuteForInterval:(NSTimeInterval)interval
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        oneMinuteSignal = [RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0.1f];
    });
    return oneMinuteSignal;
}

+ (RACDisposable *)rac_startClockwiseTimer:(CGFloat)interval subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next
{
    static CGFloat count = 0.0f;
    __block RACDisposable *disposable = nil;
    disposable = [[RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0.01f] subscribeNext:^(NSDate *date) {
        count += interval;
        if (next) {
            BOOL stop = next(date, count);
            if (stop) {
                count = 0.0f;
                [disposable dispose];
                disposable = nil;
            }
        }
    }];
    return disposable;
}


@end
