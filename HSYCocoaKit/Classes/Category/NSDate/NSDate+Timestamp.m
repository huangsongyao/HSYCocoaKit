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

#pragma mark - Read Date

- (NSDate *)readDate
{
    NSTimeZone *systemZone = [NSTimeZone systemTimeZone];
    NSTimeInterval interval = [systemZone secondsFromGMTForDate:self];
    NSDate *realDate = [self dateByAddingTimeInterval:interval];
    return realDate;
}

#pragma mark - Change Timestamp

+ (NSDate *)toDate:(NSTimeInterval)timestamp
{
    //此处的时间戳必须是除以1000以后的正确时间戳值，且此时间戳对应的是标准时间
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

+ (NSString *)stringHHmmssForDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_HHmmss timestamp:timestamp];
}

+ (NSString *)stringMM_ddForDateByTimestamp:(NSNumber *)timestamp
{
    return [NSDate toStringFormat:D_MM_dd timestamp:timestamp];
}

#pragma mark - New Date To Show Timestamp(Seconds)

+ (unsigned long long)timestampMillisecond
{
    return [[NSDate date] timestampMillisecond];
}

- (unsigned long long)timestampMillisecond
{
    return (unsigned long long)([[self readDate] timeIntervalSince1970] * _TimeSp);
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

- (NSString *)stringMM_dd
{
    return [[NSDate formatterWithString:D_MM_dd] stringFromDate:self];
}

- (NSString *)stringHHmmss
{
    return [[NSDate formatterWithString:D_HHmmss] stringFromDate:self];
}

#pragma mark - String To Show NSDate

+ (NSDate *)dateyyyyMMddHHmmssFromString:(NSString *)string
{
    return [[NSDate formatterWithString:D_yyyyMMddHHmmss] dateFromString:string];
}

#pragma mark - Next Day && Last Day

+ (NSDate *)nextDay
{
    NSDate *date = [[NSDate date] readDate];
    NSDate *nextDay = [NSDate dateWithTimeInterval:D_DAY sinceDate:date];//后一天
    
    return nextDay;
}

+ (NSDate *)lastDay
{
    NSDate *date = [[NSDate date] readDate];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-D_DAY sinceDate:date];//前一天
    
    return lastDay;
}

#pragma mark - Next Month

+ (NSDate *)nextMonth
{
    NSDate *new = [[NSDate date] readDate];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger flags = (NSCalendarUnitYear |
                        NSCalendarUnitMonth);
    NSDateComponents *dateComponent = [calendar components:flags fromDate:new];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    
    NSInteger endDate = 0;
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
    NSDictionary *weekday = @{
                              @(kHSYCocoaKitDateWeekSunday) : Sunday,
                              @(kHSYCocoaKitDateWeekMonday) : Monday,
                              @(kHSYCocoaKitDateWeekTuesday) : Tuesday,
                              @(kHSYCocoaKitDateWeekWednesday) : Wednesday,
                              @(kHSYCocoaKitDateWeekThursday) : Thursday,
                              @(kHSYCocoaKitDateWeekFriday) : Friday,
                              @(kHSYCocoaKitDateWeekSaturday) : Saturday,
                              };
    NSString *week = weekday[@(self.weekdayEnum)];
    return week;
}

- (kHSYCocoaKitDateWeek)weekdayEnum
{
    return ((kHSYCocoaKitDateWeek)self.weekday);
}

- (NSInteger)weekday
{
    NSDateComponents *comps = [self weekDateComponents];
    return comps.weekday;
}

- (NSDateComponents *)weekDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay |
                                NSCalendarUnitWeekday |
                                NSCalendarUnitHour |
                                NSCalendarUnitMinute |
                                NSCalendarUnitSecond);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:self.readDate];
    
    return comps;
}

#pragma mark - Equal Date

- (BOOL)isEqualDayToDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay);
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:self.readDate];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date.readDate];
    return ([comp1 day] == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year]);
}

- (BOOL)isEqualMonthToDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth);
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:self.readDate];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date];
    return ([comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year]);
}

- (BOOL)isEqualYearToDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = (NSCalendarUnitYear);
    NSDateComponents *comp1 = [calendar components:unitFlags fromDate:self.readDate];
    NSDateComponents *comp2 = [calendar components:unitFlags fromDate:date.readDate];
    return ([comp1 year]  == [comp2 year]);
}

+ (BOOL)beforeToDate:(NSNumber *)timestamp
{
    unsigned long long selfSecond = [NSDate date].timestampMillisecond;
    return (selfSecond < (timestamp.longLongValue/_TimeSp));
}

#pragma mark - Current Data => Current Year、Month、Day

+ (NSInteger)day:(NSDate *)date
{
    NSDateComponents *components = [[NSDate date] weekDateComponents];
    return components.day;
}

+ (NSInteger)month:(NSDate *)date
{
    NSDateComponents *components = [[NSDate date] weekDateComponents];
    return components.month;
}

+ (NSInteger)year:(NSDate *)date
{
    NSDateComponents *components = [[NSDate date] weekDateComponents];
    return components.year;
}

- (NSInteger)currentDay
{
    return [NSDate day:self];
}

- (NSInteger)currentMonth
{
    return [NSDate month:self];
}

- (NSInteger)currentYear
{
    return [NSDate year:self];
}


@end
