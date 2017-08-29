//
//  NSDate+Timestamp.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>

#define D_MINUTE	60                                  //一分钟等于60秒
#define D_HOUR		3600                                //一小时等于3600秒
#define D_DAY		86400                               //一天等于86400秒
#define D_WEEK		604800                              //一星期等于604800秒
#define D_YEAR		31556926                            //一年等于31556926秒

#define D_yyyyMMddHHmmss    @"yyyy-MM-dd HH:mm:ss"      //时间标准模式——1.年-月-日 小时:分钟:秒钟
#define D_MMddHHmm          @"MM/dd HH:mm"              //时间标准模式-—2.月/日 小时:分钟
#define D_yyyyMMdd          @"yyyy年MM月dd日"            //时间标准模式——3.年月日
#define D_yyyy_MM_dd        @"yyyy-MM-dd"               //时间标准模式——4.年-月-日
#define D_HHmm              @"HH:mm"                    //时间标准模式——5.小时:分钟
#define D_MMdd              @"MM月dd日"                  //时间标准模式——6.月日

@interface NSDate (Timestamp)

#pragma mark - 当前时间的标准北京时间

/**
 获取当前时间的标准的北京时间
 
 @return 当前时间的标准的北京时间
 */
+ (NSDate *)locationTimeZone;

#pragma mark - 时间戳和字符串显示格式转换时间变为特定的时间字符串

/**
 将时间戳转为对应格式的字符串-----时间格式详情见顶部的宏

 @param format 字符串实现时间的格式，如果“yyyy-MM-dd HH:mm:ss”
 @param timestamp 时间戳（13位，即时：未除1000的时间戳）
 @return 对应格式的时间显示字符串
 */
+ (NSString *)toStringFormat:(NSString *)format timestamp:(NSNumber *)timestamp;

#pragma mark - 固定格式转换时间戳方法

/**
 时间戳转固定格式字符串，格式为：D_yyyyMMddHHmmss

 @param timestamp 时间戳（13位，即时：未除1000的时间戳）
 @return 对应格式的时间显示字符串
 */
+ (NSString *)stringyyyyMMddHHmmssFromDateByTimestamp:(NSNumber *)timestamp;
- (NSString *)stringyyyyMMddHHmmss;

/**
 时间戳转固定格式字符串，格式为：D_MMddHHmm
 
 @param timestamp 时间戳（13位，即时：未除1000的时间戳）
 @return 对应格式的时间显示字符串
 */
+ (NSString *)stringMMddHHmmFromDateByTimestamp:(NSNumber *)timestamp;
- (NSString *)stringMMddHHmm;

/**
 时间戳转固定格式字符串，格式为：D_yyyyMMdd
 
 @param timestamp 时间戳（13位，即时：未除1000的时间戳）
 @return 对应格式的时间显示字符串
 */
+ (NSString *)stringyyyyMMddFromDateByTimestamp:(NSNumber *)timestamp;
- (NSString *)stringyyyyMMdd;

/**
 时间戳转固定格式字符串，格式为：D_yyyy_MM_dd

 @param timestamp 时间戳（13位，即时：未除1000的时间戳）
 @return 对应格式的时间显示字符串
 */
+ (NSString *)stringyyyy_MM_ddFromDateByTimestamp:(NSNumber *)timestamp;
- (NSString *)stringyyyy_MM_dd;

/**
 时间戳转固定格式字符串，格式为：D_HHmm

 @param timestamp 时间戳（13位，即时：未除1000的时间戳）
 @return 对应格式的时间显示字符串
 */
+ (NSString *)stringHHmmFromDateByTimestamp:(NSNumber *)timestamp;
- (NSString *)stringHHmm;

/**
 时间戳转固定格式字符串，格式为：D_MMdd
 
 @param timestamp 时间戳（13位，即时：未除1000的时间戳）
 @return 对应格式的时间显示字符串
 */
+ (NSString *)stringMMddForDateByTimestamp:(NSNumber *)timestamp;
- (NSString *)stringMMdd;

#pragma mark - 上一天、下一天、下个月

/**
 获取当前标准北京时间的下一天的时间

 @return 下一天的时间
 */
+ (NSDate *)nextDay;

/**
 获取当前标准北京时间的前一天的时间

 @return 前一天的时间
 */
+ (NSDate *)lastDay;

/**
 获取当前标准北京时间的下个月的时间

 @return 下个月的时间
 */
+ (NSDate *)nextMonth;

#pragma mark - 时间是星期几

/**
 获取时间对应的星期

 @return 时间对应的星期
 */
- (NSString *)dateToWeek;

@end
