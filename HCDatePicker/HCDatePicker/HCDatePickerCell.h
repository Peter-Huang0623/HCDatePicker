//
//  HCDatePickerCell.h
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCDateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCDateLabel : UILabel

- (void)drawRectWithSelecetedPosition:(HCSelectedPosition)selectedPosition
                           isSelected:(BOOL)isSelected;

@end

@interface HCDatePickerCell : UICollectionViewCell

- (void)updateCellWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
