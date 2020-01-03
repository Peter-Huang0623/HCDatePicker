//
//  HCDateModel.h
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HCDateType) {
    HCDateTypeBeforeToday = 1,
    HCDateTypeToday,
    HCDateTypeAfterToday,
};

typedef NS_ENUM(NSInteger, HCSelectedPosition) {
    HCSelectedPositionStart = 1,
    HCSelectedPositionMiddle,
    HCSelectedPositionEnd,
    HCSelectedPositionUnknown
};

@protocol HCDateModel;
@interface HCDateModel : NSObject

@property (nonatomic, assign) NSInteger year;

@property (nonatomic, assign) NSInteger month;

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger dayOfWeek;

@property (nonatomic, strong) NSNumber *dateInterval;
@property (nonatomic, assign) HCDateType dateType;
@property (nonatomic, assign) HCSelectedPosition selectedPosition;

@property (nonatomic, assign) BOOL isSelected;


@end

@interface HCDateHeaderModel : NSObject

@property (nonatomic, strong) NSString *headerString;
@property (nonatomic, assign) NSInteger year;

@property (nonatomic, strong) NSMutableArray <HCDateModel> *dateItems ;
@end
