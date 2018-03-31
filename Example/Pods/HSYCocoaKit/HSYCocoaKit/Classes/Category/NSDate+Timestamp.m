//
//  NSDate+Timestamp.m
//  Pods
//
//  Created by huangsongyao on 2017/3/30.
//
//

#import "NSDate+Timestamp.h"
#import "PublicMacroFile.h"

static NSInteger _TimeSp = 1000;                    //时间戳倍数
static NSString *_UTC    = @"UTC";                  //北京时间格式

static const NSString *Sunday       = @"星期天";
static const NSString *Monday       = @"星期一";
static const NSString *Tuesday      = @"星期二";
static const NSString *Wednesday    = @"星期三";
static const NSString *Thursday     = @"星期四";
static const NSString *Friday       = @"星期五";
static const NSString *Saturday     = @"星期六";

@implementation NSDate (Timestamp)

+ (NSDateFormatter *)formatterWithString:(NSString *)string
{
    static NSDateFormatter *shareFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareFormatter = [NSDateFormatter new];
    });
    //NSDateFormatter会自动把时间转为北京/伤害标准时间，不需要额外转换
    shareFormatter.dateFormat = string;
    return shareFormatter;
}

+ (NSDate *)locationTimeZone
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return localeDate;
}

#pragma mark - Change Timestamp

+ (NSDate *)toDate:(NSTimeInterval)timestamp
{
    //此处的时间戳必须是除以1000以后的正确时间戳值，且此时间戳对应的是🇺🇸时间
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

+ (NSString *)toStringFormat:(NSString *)format timestamp:(NSNumber *)timestamp
{
    return [[NSDate formatterWithString:format] stringFromDate:[NSDate toDate:([timestamp doubleValue]/_TimeSp)]];
}

#pragma mark - Timestamp To String

+ (NSString *)stringyyyyMMddHHmmssFromDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_yyyyMMddHHmmss timestamp:timestamp];
}

+ (NSString *)stringMMddHHmmFromDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_MMddHHmm timestamp:timestamp];
}

+ (NSString *)stringyyyyMMddFromDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_yyyyMMdd timestamp:timestamp];
}

+ (NSString *)stringyyyy_MM_ddFromDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_yyyy_MM_dd timestamp:timestamp];
}

+ (NSString *)stringHHmmFromDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_HHmm timestamp:timestamp];
}

+ (NSString *)stringMMddForDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_MMdd timestamp:timestamp];
}

#pragma mark - New Date To Show Timestamp(Seconds)

+ (unsigned long long)timestampMillisecond
{
    return (unsigned long long)([[NSDate locationTimeZone] timeIntervalSince1970] * _TimeSp);
}

- (unsigned long long)timestampMillisecond
{
    return (unsigned long long)([self timeIntervalSince1970] * _TimeSp);
}

#pragma mark - New Date To Show String

+ (NSString *)timestampString
{
    return [NSString stringWithFormat:@"%lld",[NSDate timestampMillisecond]];
}

- (NSString *)toTimestampString
{
    return [NSString stringWithFormat:@"%lld",[self timestampMillisecond]];
}

#pragma mark - NSDate To Show String

- (NSString *)stringyyyyMMddHHmmss
{
    return [[NSDate formatterWithString:D_yyyyMMddHHmmss] stringFromDate:self];
}

- (NSString *)stringMMddHHmm
{
    return [[NSDate formatterWithString:D_MMddHHmm] stringFromDate:self];
}

- (NSString *)stringyyyyMMdd
{
    return [[NSDate formatterWithString:D_yyyyMMdd] stringFromDate:self];
}

- (NSString *)stringyyyy_MM_dd
{
    return [[NSDate formatterWithString:D_yyyy_MM_dd] stringFromDate:self];
}

- (NSString *)stringHHmm
{
    return [[NSDate formatterWithString:D_HHmm] stringFromDate:self];
}

- (NSString *)stringMMdd
{
    return [[NSDate formatterWithString:D_MMdd] stringFromDate:self];
}

#pragma mark - String To Show NSDate

+ (NSDate *)dateyyyyMMddHHmmssFromString:(NSString *)string
{
    return [[NSDate formatterWithString:D_yyyyMMddHHmmss] dateFromString:string];
}

#pragma mark - Next Day && Last Day

+ (NSDate *)nextDay
{
    NSDate *date = [NSDate locationTimeZone];
    NSDate *nextDay = [NSDate dateWithTimeInterval:D_DAY sinceDate:date];//后一天
    
    return nextDay;
}

+ (NSDate *)lastDay
{
    NSDate *date = [NSDate locationTimeZone];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-D_DAY sinceDate:date];//前一天
    
    return lastDay;
}

#pragma mark - Next Month

+ (NSDate *)nextMonth
{
    NSDate *new = [NSDate locationTimeZone];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = (NSCalendarUnitYear | NSCalendarUnitMonth);
    NSDateComponents *dateComponent = [calendar components:flags fromDate:new];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    
    int endDate = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            endDate = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            endDate = 30;
            break;
        case 2:
            if (year % 400 == 0) {
                endDate = 29;
            } else {
                if (year % 100 != 0 && year %4 == 4) {
                    endDate = 29;
                } else {
                    endDate = 28;
                }
            }
            break;
        default:
            break;
    }
    
    NSDate *nextMonthDate = [NSDate dateWithTimeInterval:(D_DAY * endDate) sinceDate:new];
    return nextMonthDate;
}

#pragma mark - To Week

- (NSString *)dateToWeek
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear |
                          NSCalendarUnitMonth |
                          NSCalendarUnitDay |
                          NSCalendarUnitWeekday |
                          NSCalendarUnitHour |
                          NSCalendarUnitMinute |
                          NSCalendarUnitSecond;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:self];
    
    NSString *week = nil;
    switch (comps.weekday) {
        case 1: {
            week = [Sunday copy];
        }
            break;
        case 2: {
            week = [Monday copy];
        }
            break;
        case 3: {
            week = [Tuesday copy];
        }
            break;
        case 4: {
            week = [Wednesday copy];
        }
            break;
        case 5: {
            week = [Thursday copy];
        }
            break;
        case 6: {
            week = [Friday copy];
        }
            break;
        case 7: {
            week = [Saturday copy];
        }
            break;
        default:
            break;
    }
    
    return week;
}


@end
