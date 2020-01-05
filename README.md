# HCDatePicker
![Language](http://img.shields.io/badge/Language-Objective--C-brightgreen.svg?style=flat) [![CSDN](https://img.shields.io/badge/CSDN-Peter__Huang0623-orange.svg)](https://blog.csdn.net/Peter_Huang0623)  [![e-mail](https://img.shields.io/badge/E--mail-huangchao0623%40126.com-blue.svg)](huangchao0623@126.com)

<div align=center> <img src='https://gz.bcebos.com/v1/peterhuang/PIC/notes/DatePicker3.png' width='100%' height='100%'> </div>

## 说明

HCDatePicker是一个高度自定义的时间选择器控件，可实现单选日期和区间选择，支持自定义可选区间，支持两种显示周的方式（第一天为周一/第一天为周日）。项目中HCDatePickerController主要实现显示逻辑和点选逻辑，在HCDatePickerManager中实现数据的生成。
[项目地址](https://github.com/Peter-Huang0623/HCDatePicker)

## 预览图
<div align=center> <img src='https://gz.bcebos.com/v1/peterhuang/PIC/notes/DatePickerPreview.png' width='40%' height='40%'> </div>

## 自定义

```Objective-C
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
 *      YES     ---     一周的第一天是周一
 *      NO      ---     一周的第一天是周日
 */
@property (nonatomic, assign) BOOL firstDayOfWeekIsMonday;

```


## TODO
* [ ] 选中状态颜色可配置
* [x] 顶部文字提示随系统语言变换
* [ ] 下拉选择年份