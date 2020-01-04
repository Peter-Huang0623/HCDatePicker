//
//  HCDatePickerCell.m
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import "HCDatePickerCell.h"
#import <Masonry/Masonry.h>
#import "HCDateModel.h"

#define     RGBA(r, g, b, a)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
@interface HCDateLabel ()

@property (nonatomic, assign) HCSelectedPosition selectedPosition;
@property (nonatomic, assign) BOOL isSelected;


@end
@implementation HCDateLabel

- (void)drawRect:(CGRect)rect
{
    
    CGFloat margin = 5.0f;
    CGFloat itemW = rect.size.width - 2 * margin;
    
    switch (_selectedPosition) {
        case HCSelectedPositionStart: {
            CGRect frame = CGRectMake(margin, margin, itemW, itemW);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [[UIColor whiteColor] set];
            CGContextFillRect(context, rect);
            CGContextAddEllipseInRect(context, frame);
            [RGBA(22, 101, 216, 1) set];
            CGContextFillPath(context);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGContextMoveToPoint(context, rect.size.width / 2, margin);
            CGContextAddLineToPoint(context, rect.size.width, margin);
            CGContextAddLineToPoint(context, rect.size.width, margin + itemW);
            CGContextAddLineToPoint(context, rect.size.width / 2, margin + itemW);
            CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, itemW / 2, M_PI_2, -M_PI_2, 1);
            CGContextAddPath(context, path);
            CGContextSetFillColorWithColor(context, RGBA(185, 208, 243, 1).CGColor);
            CGContextFillPath(context);
            CGPathRelease(path);
        }
            break;
        case HCSelectedPositionMiddle: {
            CGMutablePathRef path = CGPathCreateMutable();
            CGRect rectangle = CGRectMake(0, margin, rect.size.width, itemW);
            CGPathAddRect(path,NULL, rectangle);
            CGContextRef currentContext = UIGraphicsGetCurrentContext();
            CGContextAddPath(currentContext, path);
            [RGBA(185, 208, 243, 1) setFill];
            [[UIColor clearColor] setStroke];
            CGContextSetLineWidth(currentContext,0.0f);
            CGContextDrawPath(currentContext, kCGPathFillStroke);
            CGPathRelease(path);
        }
            break;
        case HCSelectedPositionEnd: {
            CGRect frame = CGRectMake(margin, margin, itemW, itemW);
            CGContextRef context = UIGraphicsGetCurrentContext();
            [[UIColor whiteColor] set];
            CGContextFillRect(context, rect);
            CGContextAddEllipseInRect(context, frame);
            [RGBA(22, 101, 216, 1) set];
            CGContextFillPath(context);
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGContextMoveToPoint(context, rect.size.width / 2, margin);
            CGContextAddLineToPoint(context, 0, margin);
            CGContextAddLineToPoint(context, 0, margin + itemW);
            CGContextAddLineToPoint(context, rect.size.width / 2, margin + itemW);
            CGContextAddArc(context, rect.size.width / 2, rect.size.height / 2, itemW / 2, M_PI_2, -M_PI_2, 0);
            CGContextAddPath(context, path);
            CGContextSetFillColorWithColor(context, RGBA(185, 208, 243, 1).CGColor);
            CGContextFillPath(context);
            CGPathRelease(path);
        }
            break;
        case HCSelectedPositionUnknown: {
            if (_isSelected) {
                CGRect frame = CGRectMake(margin, margin, itemW, itemW);
                CGContextRef context = UIGraphicsGetCurrentContext();
                [[UIColor whiteColor] set];
                CGContextFillRect(context, rect);
                CGContextAddEllipseInRect(context, frame);
                [RGBA(22, 101, 216, 1) set];
                CGContextFillPath(context);
            }
        }
            break;
        default:
            break;
    }
    [super drawRect:rect];
}

- (void)drawRectWithSelecetedPosition:(HCSelectedPosition)selectedPosition
                           isSelected:(BOOL)isSelected
{
    _selectedPosition = selectedPosition;
    _isSelected = isSelected;
    [self setNeedsDisplay];
}

@end

@interface HCDatePickerCell ()

@property (nonatomic, strong) HCDateLabel *titleLabel;
@property (nonatomic, assign) HCSelectedPosition selectedPosition;
@property (nonatomic, assign) BOOL isSelected;

@end

@implementation HCDatePickerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initContentView];
    }
    return self;
}

- (void)initContentView
{
    _titleLabel = [[HCDateLabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:12];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)updateCellWithData:(id)data
{
    HCDateModel *dateModel = (HCDateModel *)data;
    if (dateModel.day >= 1) {
        _titleLabel.text = [NSString stringWithFormat:@"%ld",dateModel.day];
    }
    else {
        _titleLabel.text = @"";
    }
    if (dateModel.dateType == HCDateTypeToday ||
        dateModel.dateType == HCDateTypeBeforeToday) {
        _titleLabel.textColor = [UIColor blackColor];
    }
    else {
        _titleLabel.textColor = [UIColor grayColor];
    }
    if ((dateModel.selectedPosition == HCSelectedPositionStart || dateModel.selectedPosition == HCSelectedPositionEnd ||
        dateModel.selectedPosition == HCSelectedPositionUnknown) && dateModel.isSelected ) {
        _titleLabel.textColor = [UIColor whiteColor];
    }
    [_titleLabel drawRectWithSelecetedPosition:dateModel.selectedPosition isSelected:dateModel.isSelected];
}

@end
