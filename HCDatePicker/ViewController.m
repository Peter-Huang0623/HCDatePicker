//
//  ViewController.m
//  HCDatePicker
//
//  Created by Peter on 02/01/2020.
//  Copyright © 2020 Peter. All rights reserved.
//

#import "ViewController.h"
#import "HCDatePickerController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0f green:128/255.0f blue:255/255.0f alpha:1];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 32, 40)];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.center = self.view.center;
    _timeLabel.text = @"Time Will be Displayed here";
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_timeLabel];
    
    UIButton *popUpDatePickerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    popUpDatePickerBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    [self.view addSubview:popUpDatePickerBtn];
    [popUpDatePickerBtn setTitle:@"Click Me!" forState:UIControlStateNormal];
    [popUpDatePickerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    popUpDatePickerBtn.backgroundColor = [UIColor whiteColor];
    popUpDatePickerBtn.layer.cornerRadius = 20;
    popUpDatePickerBtn.layer.shadowOffset = CGSizeMake(0, 1);
    popUpDatePickerBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    popUpDatePickerBtn.layer.shadowOpacity = 0.1;
    popUpDatePickerBtn.layer.shadowRadius = 1;
    [popUpDatePickerBtn addTarget:self action:@selector(onDatePickerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onDatePickerButtonClick:(UIButton *)btn
{
    HCDatePickerController *vc = [[HCDatePickerController alloc] init];
    vc.firstDayOfWeekIsMonday = YES;
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
