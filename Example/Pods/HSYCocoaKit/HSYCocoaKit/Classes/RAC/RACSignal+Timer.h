//
//  RACSignal+Timer.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACSignal (Timer)

/**
 *  rac 计时器，间隔时间1.0f秒
 *
 *  @return 计时器信号
 */
+ (RACSignal *)rac_timerSignalOneMinute;

/**
 *  rac 计时器
 *
 *  @param interval 间隔调用时间
 *
 *  @return 计时器信号
 */
+ (RACSignal *)rac_timerSignalOneMinuteForInterval:(NSTimeInterval)interval;

/**
 顺时针计时器

 @param interval 计时器调用的间隔时间
 @param next 事件触发的回调
 @return rac计时器
 */
+ (RACDisposable *)rac_startClockwiseTimer:(CGFloat)interval subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;


@end
