//
//  RACSignal+Timer.h
//  Pods
//
//  Created by huangsongyao on 2017/3/27.
//
//

#import "ReactiveCocoa.h"

@interface RACSignal (Timer)

/**
 *  rac 计时器，间隔时间1.0f秒，单例模式
 *
 *  @return 计时器信号
 */
+ (RACSignal *)hsy_rac_timerSignalOneMinute;

/**
 *  rac 计时器，单例模式
 *
 *  @param interval 间隔调用时间
 *
 *  @return 计时器信号
 */
+ (RACSignal *)hsy_rac_timerSignalOneMinuteForInterval:(NSTimeInterval)interval;

/**
 顺时针计时器

 @param interval 计时器调用的间隔时间
 @param next 事件触发的回调
 @return rac计时器
 */
+ (RACDisposable *)hsy_rac_startClockwiseTimer:(CGFloat)interval subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

/**
 顺时针计时器，调用间隔时间1.0f秒

 @param next 触发回调事件
 @return 线程计时器
 */
+ (RACDisposable *)hsy_rac_startClockwiseTimerSubscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

/**
 顺时针计时器，间隔时间1秒，单例模式
 
 @param next 事件触发的回调
 @return 线程计时器
 */
+ (RACDisposable *)hsy_rac_timerDisposableOneMinuteSubscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

/**
 顺时针计时器，单例模式
 
 @param interval 触发间隔时间
 @param next 事件触发的回调
 @return 线程计时器
 */
+ (RACDisposable *)hsy_rac_timerDisposableOneMinuteForInterval:(NSTimeInterval)interval subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

@end
