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
 顺时针计时器，间隔一秒响应，单例模式
 
 @param critical 临界值，即：计时器的最大值
 @param next 事件触发的回调
 @return 线程计时器
 */
+ (RACDisposable *)hsy_rac_timerDisposableOneMinute:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

/**
 顺时针计时器，单例模式
 
 @param interval 触发事件的间隔时间
 @param critical 临界值，即：计时器的最大值
 @param next 事件触发的回调
 @return 线程计时器
 */
+ (RACDisposable *)hsy_rac_timerDisposableOneMinuteForInterval:(NSTimeInterval)interval criticalValue:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

/**
 顺时针计时器
 
 @param interval 触发事件的间隔时间
 @param critical 临界值，即：计时器的最大值
 @param next 事件触发的回调
 @return 线程计时器
 */
+ (RACDisposable *)hsy_rac_startClockwiseTimer:(CGFloat)interval criticalValue:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

/**
 顺时针计时器，间隔一秒响应
 
 @param critical 临界值，即：计时器的最大值
 @param next 事件触发的回调
 @return 线程计时器
 */
+ (RACDisposable *)hsy_rac_startClockwiseTimer:(CGFloat)critical subscribeNext:(BOOL(^)(NSDate *date, CGFloat count))next;

/**
 停止顺时针单例计时器
 */
+ (void)hsy_rac_stopTimerDisposableOneMinute;

@end
