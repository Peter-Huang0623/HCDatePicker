//
//  HCDatePickerManager.m
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import "HCDatePickerManager.h"
#import "HCDateModel.h"

@implementation HCDatePickerManager

- (NSArray *)getDatePickerDataWithFromDate:(NSDate *)fromDate
{
    NSMutableArray *data = [NSMutableArray array];
    NSDateComponents *components = [self dateToComponents:fromDate];
    components.day = 1;
    NSInteger startYear = components.year;
    NSInteger endYear = [self dateToComponents:[NSDate date]].year;
    NSInteger currentMonthOfCurrentYear = [self monthOfYear:[NSDate date]];
    for (NSInteger year = startYear; year <= endYear; year++) {
        components.year = year;
        for (int month = 1; month <= (year == endYear ? currentMonthOfCurrentYear : 12); month++) {
            components.month = month;
            components.day = 1;
            HCDateHeaderModel *headerModel = [[HCDateHeaderModel alloc] init];
            headerModel.headerString = [NSString stringWithFormat:@"%ld年%d月",year, month];
            headerModel.year = year;
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
    return c.weekday;
}

- (NSInteger)monthOfYear:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *c = [calendar components:NSCalendarUnitMonth fromDate:date];
    return c.month;
}
@end
