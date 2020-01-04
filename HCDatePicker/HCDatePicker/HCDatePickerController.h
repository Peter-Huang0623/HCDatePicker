//
//  HCDatePickerController.h
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HCDatePickerSelectionType) {
    HCDatePickerSelectionTypeSingle = 1,
    HCDatePickerSelectionTypeMulti,
    HCDatePickerSelectionTypeBoth
};

@interface HCDatePickerController : UIViewController

/*
 *      datePicker的时间范围的开始时间（毫秒）
 *      若未设置，默认为2000-01-01-00:00:00:0000
 */
@property (nonatomic, strong) NSNumber *startDateInterval;

/*
 *      datePicker的时间范围的结束时间（毫秒）
 *      若未设置，默认为当前日期所在月份最后一天的00:00:00:000
 */
@property (nonatomic, strong) NSNumber *endDateInerval;

/*
 *      HCDatePickerSelectionTypeSingle     ---     单日选择
 *      HCDatePickerSelectionTypeMulti      ---     区间选择
 *      HCDatePickerSelectionTypeBoth       ---     单日&区间
 *
 *      NOTE:单日选择模式下，返回的日期为选择日期当日的00:00
 *           区间选择模式下，返回的日期为起始日期的00:00 到 截止日期的00:00
 */
@property (nonatomic, assign) HCDatePickerSelectionType selectionType;

/*
 *      是否可选中当前日期之后的日期
 */
@property (nonatomic, assign) BOOL canSelectDateAfterToday;

/*
 *      选中开始时间和结束时间的颜色样式【默认为RGBA(22, 101, 216, 1)】
 */
@property (nonatomic, strong) UIColor *startAndEndDateColor;

/*
 *      选中开始时间和截止时间之间的颜色样式【默认为RGBA(185, 208, 243, 1)】
 */
@property (nonatomic, strong) UIColor *middleDateColor;

/*
 *      YES     ---     一周的第一天是周日
 *      NO      ---     一周的第一天是周一
 */
@property (nonatomic, assign) BOOL startDayOfWeekIsSunday;

@end

NS_ASSUME_NONNULL_END
