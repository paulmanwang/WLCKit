//
//  NSDate+WLC.h
//  Training
//
//  Created by lichunwang on 16/12/28.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WLC)

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger weekday;
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) BOOL isToday;
@property (nonatomic, readonly) BOOL isYesterday;

+ (NSInteger)currentMonth;
+ (NSInteger)currentYear;
+ (NSInteger)currentDay;
+ (NSInteger)currentWeekday;

- (instancetype)dateByAddingYears:(NSInteger)years;
- (instancetype)dateByAddingMonths:(NSInteger)months;
- (instancetype)dateByAddingDays:(NSInteger)days;
- (instancetype)dateByAddingHours:(NSInteger)hours;
- (instancetype)dateByAddingMinutes:(NSInteger)minutes;
- (instancetype)dateByAddingSeconds:(NSInteger)seconds;

+ (instancetype)dateWithString:(NSString *)dateString format:(NSString *)format;
+ (instancetype)dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone local:(NSLocale *)local;

+ (NSInteger)daysOfMonth:(NSInteger)month inYear:(NSInteger)year;

+ (BOOL)oneDate:(NSString *)oneDate isGreaterThanAnotherDate:(NSString *)anohterDate;

@end
