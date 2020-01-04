//
//  HCDatePickerController.m
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import "HCDatePickerController.h"
#import <Masonry/Masonry.h>
#import "HCDatePickerCell.h"
#import "HCDatePickerManager.h"
#import "HCDateModel.h"

#define     SCREEN_HEIGHT       [UIScreen mainScreen].bounds.size.height
#define     SCREEN_WIDTH        [UIScreen mainScreen].bounds.size.width
#define     DATE_PICKER_W_H_RATIO   (251.0f / 256.0f)

#define     RGBA(R,G,B,A)       [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

@interface HCDatePickerController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *contentCollectionView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) HCDatePickerManager *datePickerManager;
@property (nonatomic, assign) NSInteger currentYearIndex;
@property (nonatomic, strong) NSNumber *startTimeInterval;
@property (nonatomic, strong) NSNumber *endTimeInterval;


@end

@implementation HCDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initContentView];
}

- (void)initData
{
    _datePickerManager = [[HCDatePickerManager alloc] init];
    HCDatePickerConfig *config = [[HCDatePickerConfig alloc] init];
    config.firstDayOfWeekIsMonday = self.firstDayOfWeekIsMonday;
    _dataArray = [_datePickerManager getDatePickerDataWithFromDate:nil toDate:nil config:config];
    _currentYearIndex = _dataArray.count - 1;
}

- (void)initContentView
{
    UIView *containerView = [[UIView alloc] init];
    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(SCREEN_WIDTH * DATE_PICKER_W_H_RATIO + 30));
    }];
    containerView.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    [containerView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containerView);
        make.top.equalTo(containerView).offset(21);
    }];
    _titleLabel.text = ((HCDateHeaderModel *)_dataArray[_currentYearIndex]).headerString;
    _titleLabel.textColor = RGBA(0, 0, 0, 0.54);
    _titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    UIButton *arrowDownButton = [[UIButton alloc] init];
    [containerView addSubview:arrowDownButton];
    [arrowDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_right).offset(10);
        make.centerY.equalTo(_titleLabel);
        make.width.equalTo(@10);
        make.height.equalTo(@5);
    }];
    [arrowDownButton setImage:[UIImage imageNamed:@"arrow drop down"] forState:UIControlStateNormal];
    [arrowDownButton addTarget:self action:@selector(onArrowDownBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftArrowButton = [[UIButton alloc] init];
    [containerView addSubview:leftArrowButton];
    [leftArrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(containerView).offset(24);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(_titleLabel);
    }];
    [leftArrowButton setImage:[UIImage imageNamed:@"chevron left"] forState:UIControlStateNormal];
    [leftArrowButton addTarget:self action:@selector(onLeftArrowClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightArrowButton = [[UIButton alloc] init];
    [containerView addSubview:rightArrowButton];
    [rightArrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-24);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(_titleLabel);
    }];
    [rightArrowButton setImage:[UIImage imageNamed:@"chevron right"] forState:UIControlStateNormal];
    [rightArrowButton addTarget:self action:@selector(onRightArrowClick) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 18, 0, 18);
    
    CGFloat itemW = (SCREEN_WIDTH - 2 * 18) / 7;
    CGSize itemSize = CGSizeMake(itemW, itemW);
    flowLayout.itemSize = itemSize;
    
    NSArray *englishWeekArray = @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat"];
    NSArray *chineseWeekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    if (self.firstDayOfWeekIsMonday) {
        englishWeekArray = @[@"Mon",@"Tue",@"Wed",@"Thu",@"Fri",@"Sat",@"Sun"];
        chineseWeekArray = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    }
    for (int i = 0; i < 7; i ++) {
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemW * i + 18, 51, itemW, itemW)];
        weekLabel.textColor = RGBA(0, 0, 0, 0.38);
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.text = [self systemLanguageIsChinese] ? chineseWeekArray[i] : englishWeekArray[i];
        weekLabel.font = [UIFont boldSystemFontOfSize:12];
        [containerView addSubview:weekLabel];
    }
    
    _contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _contentCollectionView.backgroundColor = [UIColor clearColor];
    _contentCollectionView.delegate = self;
    _contentCollectionView.dataSource = self;
    [self.view addSubview:_contentCollectionView];
    [_contentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView).offset(51 + itemW);
        make.left.bottom.right.equalTo(containerView);
    }];
    [_contentCollectionView registerClass:[HCDatePickerCell class] forCellWithReuseIdentifier:NSStringFromClass([HCDatePickerCell class])];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    HCDateHeaderModel *headerModel = _dataArray[_currentYearIndex];
    return headerModel.dateItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCDatePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HCDatePickerCell class]) forIndexPath:indexPath];
    HCDateHeaderModel *headerModel = _dataArray[_currentYearIndex];
    HCDateModel *dateModel = headerModel.dateItems[indexPath.row];
    dateModel.isSelected = NO;
    dateModel.selectedPosition = HCSelectedPositionUnknown;
    
    if (_startTimeInterval && _endTimeInterval) {
        if ([dateModel.dateInterval isEqualToNumber:_startTimeInterval]) {
            dateModel.selectedPosition = HCSelectedPositionStart;
            dateModel.isSelected = YES;
        }
        else if ([dateModel.dateInterval isEqualToNumber:_endTimeInterval]) {
            dateModel.selectedPosition = HCSelectedPositionEnd;
            dateModel.isSelected = YES;
        }
        else if (([dateModel.dateInterval longLongValue] > [_startTimeInterval longLongValue]) && ([dateModel.dateInterval longLongValue] < [_endTimeInterval longLongValue])) {
            dateModel.selectedPosition = HCSelectedPositionMiddle;
            dateModel.isSelected = YES;
        }
        else {
            dateModel.selectedPosition = HCSelectedPositionUnknown;
            dateModel.isSelected = NO;
        }
    }
    else if (_startTimeInterval && _endTimeInterval == nil) {
        if ([dateModel.dateInterval isEqualToNumber:_startTimeInterval]) {
            dateModel.selectedPosition = HCSelectedPositionUnknown;
            dateModel.isSelected = YES;
        }
    }
    else {
        
    }
    [cell updateCellWithData:dateModel];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCDateHeaderModel *headerModel = _dataArray[_currentYearIndex];
    HCDateModel *dateModel = headerModel.dateItems[indexPath.row];
    if (dateModel.dateType == HCDateTypeAfterToday && !self.canSelectDateAfterToday) {
        return;
    }
    if (!_startTimeInterval) {
        _startTimeInterval = dateModel.dateInterval;
    }
    else if (!_endTimeInterval) {
        if ([dateModel.dateInterval longLongValue] > [_startTimeInterval longLongValue]) {
            _endTimeInterval = dateModel.dateInterval;
        }
        else {
            _endTimeInterval = _startTimeInterval;
            _startTimeInterval = dateModel.dateInterval;
        }
    }
    else {
        _startTimeInterval = dateModel.dateInterval;
        _endTimeInterval = nil;
    }
    [_contentCollectionView reloadData];
    
    if ((self.selectionType == HCDatePickerSelectionTypeSingle && _startTimeInterval) ||
        (_startTimeInterval && _endTimeInterval)) {
        collectionView.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onArrowDownBtnClick
{
    
}

- (void)onLeftArrowClick
{
    if (_currentYearIndex < 1) {
        return;
    }
    _currentYearIndex -= 1;
    _titleLabel.text = ((HCDateHeaderModel *)_dataArray[_currentYearIndex]).headerString;
    [_contentCollectionView reloadData];
}

- (void)onRightArrowClick
{
    if (_currentYearIndex >= _dataArray.count - 1) {
        return;
    }
    _currentYearIndex += 1;
    _titleLabel.text = ((HCDateHeaderModel *)_dataArray[_currentYearIndex]).headerString;
    [_contentCollectionView reloadData];
}

- (BOOL)systemLanguageIsChinese
{
    NSArray *array = [NSLocale preferredLanguages];
    NSString *languageStr = array[0];
    return [languageStr hasPrefix:@"zh"];
}
@end
