//
//  HCDatePickerManager.m
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import "HCDatePickerManager.h"
#import "HCDateModel.h"

@implementation HCDatePickerConfig

@end

@interface HCDatePickerManager ()

@property (nonatomic, strong) NSNumber *todayInterval;
@property (nonatomic, strong) HCDatePickerConfig *config;

@end

@implementation HCDatePickerManager

- (NSArray *)getDatePickerDataWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate config:(HCDatePickerConfig *)config
{
    _config = config;
    NSMutableArray *data = [NSMutableArray array];
    NSDateComponents *components = [self dateToComponents:fromDate ? fromDate : [NSDate dateWithTimeIntervalSince1970:946656035]];
    components.day = 1;
    NSInteger startYear = components.year;
    NSInteger endYear = [self dateToComponents:toDate ? toDate : [NSDate date]].year;
    NSInteger currentMonthOfCurrentYear = [self monthOfYear:[NSDate date]];
    for (NSInteger year = startYear; year <= endYear; year++) {
        components.year = year;
        for (int month = 1; month <= (year == endYear ? currentMonthOfCurrentYear : 12); month++) {
            components.month = month;
            components.day = 1;
            HCDateHeaderModel *headerModel = [[HCDateHeaderModel alloc] init];
            headerModel.year = year;
            headerModel.month = month;
            headerModel.dateItems = [NSMutableArray<HCDateModel> array];
            for (NSInteger i = 1; i < [self dayOfWeek:[self componentsToDate:components]]; i++) {
                HCDateModel *dateModel = [[HCDateModel alloc] init];
                dateModel.year = -1;
                dateModel.month = -1;
                dateModel.day = -1;
                dateModel.dayOfWeek = -1;
                dateModel.dateInterval = @(-1);
                [headerModel.dateItems addObject:dateModel];
            }
            NSDate *tempDate = [self componentsToDate:components];
            while (components.day <= [self numberOfDaysInCurrentMonth:tempDate]) {
                HCDateModel *dateModel = [[HCDateModel alloc] init];
                dateModel.year = year;
                dateModel.month = month;
                dateModel.day = components.day;
                dateModel.dayOfWeek = [self dayOfWeek:[self componentsToDate:components]];
                dateModel.dateInterval = [self componentsToNanoSecondsInterval:components];
                if ([dateModel.dateInterval isEqualToNumber:self.todayInterval]) {
                    dateModel.dateType = HCDateTypeToday;
                }
                else if ([dateModel.dateInterval longLongValue] > [self.todayInterval longLongValue]) {
                    dateModel.dateType = HCDateTypeAfterToday;
                }
                else {
                    dateModel.dateType = HCDateTypeBeforeToday;
                }
                [headerModel.dateItems addObject:dateModel];
                components.day += 1;
            }
            [data addObject:headerModel];
        }
        
    }
    
    return [NSArray arrayWithArray:data];
}


- (NSDateComponents *)dateToComponents:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
}

- (NSNumber *)componentsToNanoSecondsInterval:(NSDateComponents *)components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:components];
    return @([date timeIntervalSince1970] * 1000);
}

- (NSDate *)componentsToDate:(NSDateComponents *)components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:components];
}

- (NSInteger)numberOfDaysInCurrentMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

- (NSInteger)dayOfWeek:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *c = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSInteger a = c.weekday > 1 ? c.weekday - 1 : 7;
    return _config.firstDayOfWeekIsMonday ? a : c.weekday;
}

- (NSInteger)monthOfYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *c = [calendar components:NSCalendarUnitMonth fromDate:date];
    return c.month;
}

- (NSNumber *)todayInterval
{
    if (!_todayInterval) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *c = [calendar components:NSCalendarUnitDay | NSCalendarUnitYear | NSCalendarUnitMonth fromDate:[NSDate date]];
        NSDate *today = [calendar dateFromComponents:c];
        _todayInterval = @([today timeIntervalSince1970] * 1000);
    }
    return _todayInterval;
}

@end
