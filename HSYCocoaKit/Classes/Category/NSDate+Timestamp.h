//
//  NSDate+Timestamp.h
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, kHSYCocoaKitDateWeek) {
    
    kHSYCocoaKitDateWeekSunday            = 1,          //星期日
    kHSYCocoaKitDateWeekMonday            = 2,          //星期一
    kHSYCocoaKitDateWeekTuesday           = 3,          //星期二
    kHSYCocoaKitDateWeekWednesday         = 4,          //星期三
    kHSYCocoaKitDateWeekThursday          = 5,          //星期四
    kHSYCocoaKitDateWeekFriday            = 6,          //星期五
    kHSYCocoaKitDateWeekSaturday          = 7,          //星期六
};

static const NSString *Sunday       = @"星期天";
static const NSString *Monday       = @"星期一";
static const NSString *Tuesday      = @"星期二";
static const NSString *Wednesday    = @"星期三";
static const NSString *Thursday     = @"星期四";
static const NSString *Friday       = @"星期五";
static const NSString *Saturday     = @"星期六";


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

#pragma mark - 当前设备所在地区的真实时间

/**
 获取当前时间的标准地区时间（即，设备所处位置的时间）
 
 @return 标准时间转设备所处位置的时间
 */
- (NSDate *)readDate;

#pragma mark - 标准时间转为对应的当地时间的秒数

/**
 [NSDate date]转为设备所在地区的时间的秒数

 @return 设备所在地区的时间的秒数
 */
+ (unsigned long long)timestampMillisecond;

/**
 把时间转为设备所在地区的时间的秒数

 @return 设备所在地区的时间的秒数
 */
- (unsigned long long)timestampMillisecond;

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
 获取时间对应的星期几

 @return 时间对应的星期几
 */
- (NSString *)dateToWeek;

/**
 获取时间对应的星期几的枚举

 @return 时间对应的星期几的枚举
 */
- (kHSYCocoaKitDateWeek)weekdayEnum;

#pragma mark - 当前时间的日期、月份、年份

/**
 当前时间的日期

 @return 日期，[1, 31]，闭区间
 */
- (NSInteger)currentDay;

/**
 当前时间的月份

 @return 月份，[1, 12]，闭区间
 */
- (NSInteger)currentMonth;

/**
 当前时间的年份

 @return 年份
 */
- (NSInteger)currentYear;

#pragma mark - 日期判断

/**
 判断两个日期是否处于同一天

 @param date 日期
 @return 是否处于同一天
 */
- (BOOL)isEqualDayToDate:(NSDate *)date;

/**
 判断两个日期是否处于同一个月

 @param date 日期
 @return 是否处于同一个月
 */
- (BOOL)isEqualMonthToDate:(NSDate *)date;

/**
 判断两个日期是否处于同一年

 @param date 日期
 @return 是否处于同一年
 */
- (BOOL)isEqualYearToDate:(NSDate *)date;

/**
 判断当前设备所在地区的时间是否在另一个时间戳之前

 @param timestamp 另一个时间戳
 @return YES表示self指针所指向的时间在参数date时间之前
 */
+ (BOOL)beforeToDate:(NSNumber *)timestamp;

@end
