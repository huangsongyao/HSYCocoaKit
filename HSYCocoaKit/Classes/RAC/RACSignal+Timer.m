//
//  RACSignal+Timer.m
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "RACSignal+Timer.h"

static RACSignal *oneMinuteSignal = nil;
static RACDisposable *oneMinuteDisposable = nil;

@implementation RACSignal (Timer)

#pragma mark - RACSignal Singleton Timer

+ (RACSignal *)hsy_rac_timerSignalOneMinute
{
    return [RACSignal hsy_rac_timerSignalOneMinuteForInterval:1.0f];
}

+ (RACSignal *)hsy_rac_timerSignalOneMinuteForInterval:(NSTimeInterval)interval
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        oneMinuteSignal = [RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0.1f];
    });
    return oneMinuteSignal;
}

#pragma mark - RACDisposable Singleton Timer

+ (RACDisposable *)hsy_rac_timerDisposableOneMinute:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next
{
    return [self.class hsy_rac_timerDisposableOneMinuteForInterval:1.0f criticalValue:critical subscribeNext:next];
}

+ (RACDisposable *)hsy_rac_timerDisposableOneMinuteForInterval:(NSTimeInterval)interval criticalValue:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next
{
    RACDisposable *disposable = [self.class rac_timerDisposableOneMinuteForInterval:interval criticalValue:critical subscribeNext:next];
    [disposable dispose];
    return disposable;
}

+ (RACDisposable *)rac_timerDisposableOneMinuteForInterval:(NSTimeInterval)interval criticalValue:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        oneMinuteDisposable = [self.class hsy_rac_startClockwiseTimer:interval criticalValue:critical subscribeNext:next];
    });
    return oneMinuteDisposable;
}

+ (void)hsy_rac_stopTimerDisposableOneMinute
{
    if (oneMinuteDisposable) {
        [oneMinuteDisposable dispose];
    }
}

#pragma mark - RACDisposable Timer

+ (RACDisposable *)hsy_rac_startClockwiseTimer:(CGFloat)interval criticalValue:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next
{
    static CGFloat count = 0.0f;
    __block RACDisposable *disposable = nil;
    disposable = [[RACSignal interval:interval onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0.001f] subscribeNext:^(NSDate *date) {
        count += interval;
        if (next) {
            BOOL stop = next(date, count);
            if (stop && (count >= critical)) {
                count = 0.0f;
                [disposable dispose];
                disposable = nil;
            }
        }
    }];
    return disposable;
}

+ (RACDisposable *)hsy_rac_startClockwiseTimer:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next
{
    RACDisposable *disposable = [self.class hsy_rac_startClockwiseTimer:1.0f criticalValue:critical subscribeNext:next];
    return disposable;
}

@end
