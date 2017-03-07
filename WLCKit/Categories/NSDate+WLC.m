//
//  NSDate+WLC.m
//  Training
//
//  Created by lichunwang on 16/12/28.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "NSDate+WLC.h"

@implementation NSDate (WLC)

- (NSInteger)year
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitNanosecond fromDate:self] nanosecond];
}

- (NSInteger)weekday
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear
{
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

+ (NSInteger)currentYear
{
    return [[NSDate date] year];
}

+ (NSInteger)currentMonth
{
    return [[NSDate date] month];
}

+ (NSInteger)currentDay
{
    return [[NSDate date] day];
}

+ (NSInteger)currentWeekday
{
    return [[NSDate date] weekday];
}

- (BOOL)isToday;
{
    NSDate *today = [NSDate date];
    if (today.year == self.year && today.month == self.month && today.day == self.day) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isYesterday
{
    NSDate *today = [self dateByAddingDays:1];
    return [today isToday];
}

- (instancetype)dateByAddingYears:(NSInteger)years
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    [components setYear:years];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (instancetype)dateByAddingMonths:(NSInteger)months
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [NSDateComponents new];
    [components setMonth:months];
    
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (instancetype)dateByAddingDays:(NSInteger)days
{
    return [self dateByAddingTimeInterval:86400 * days];
}

- (instancetype)dateByAddingHours:(NSInteger)hours
{
    return [self dateByAddingTimeInterval:3600 * hours];
}
- (instancetype)dateByAddingMinutes:(NSInteger)minutes
{
    return [self dateByAddingTimeInterval:60 * minutes];
}

- (instancetype)dateByAddingSeconds:(NSInteger)seconds
{
    return [self dateByAddingTimeInterval:seconds];
}

+ (instancetype)dateWithString:(NSString *)dateString format:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:dateString];
}

+ (instancetype)dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone local:(NSLocale *)local
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:format];
    if (timeZone) {
        [formatter setTimeZone:timeZone];
    }
    if (local) {
        [formatter setLocale:local];
    }
    
    return [formatter dateFromString:dateString];
}

+ (NSInteger)daysOfMonth:(NSInteger)month inYear:(NSInteger)year
{
    NSString *dateString = [NSString stringWithFormat:@"%li-%li-01", year, month];
    NSDate *date = [self dateWithString:dateString format:@"yy-MM-dd"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return range.length;
}

+ (BOOL)oneDate:(NSString *)oneDate isGreaterThanAnotherDate:(NSString *)anohterDate
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    NSDate *date1 = [dateFormatter dateFromString:oneDate];
    NSDate *date2 = [dateFormatter dateFromString:anohterDate];
    NSComparisonResult result = [date1 compare:date2];
    if (result == NSOrderedDescending || result == NSOrderedSame) { // The left operand is greater than the right operand.
        return YES;
    }
    
    return NO;
}

@end
