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
+ (RACSignal *)timerSignalOneMinute;

/**
 *  rac 计时器
 *
 *  @param interval 间隔调用时间
 *
 *  @return 计时器信号
 */
+ (RACSignal *)timerSignalOneMinuteForInterval:(NSTimeInterval)interval;

@end
