//
//  HCDatePickerManager.h
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCDatePickerConfig : NSObject

@property (nonatomic, assign) BOOL firstDayOfWeekIsMonday;

@end

@interface HCDatePickerManager : NSObject

- (NSArray *)getDatePickerDataWithFromDate:(nullable NSDate *)fromDate toDate:(nullable NSDate *)toDate config:(HCDatePickerConfig *)config;

@end

NS_ASSUME_NONNULL_END
