//
//  WLCDatePicker.m
//  Training
//
//  Created by lichunwang on 16/12/21.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCDatePicker.h"
#import "UIView+WLC.h"
#import "NSBundle+WLC.h"

static NSMutableDictionary *datePickerDic;

@interface WLCDatePicker ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation WLCDatePicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tapGesture];
}

- (void)onTap:(UITapGestureRecognizer *)gesture
{
    [self dismiss];
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

+ (void)initialize
{
    // 如果有子类继承，会导致多次调用，这里做一次防护。这里没有子类继承，没有必要
    if (self == [WLCDatePicker class]) {
        datePickerDic = [NSMutableDictionary new];
    }
}

+ (instancetype)wlcDatePicker
{
    return (WLCDatePicker *)[[NSBundle wlcKitBundle] loadNibNamed:@"WLCDatePicker" owner:nil options:nil][0];
}

- (void)show
{
    self.containerView.top = self.bottom;
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.bottom = self.bottom;
    }];
}

- (void)dismiss
{
    CGFloat orgBottom = self.containerView.bottom;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.containerView.top = orgBottom;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

+ (instancetype)showDatePickerOnViewContoller:(UIViewController *)viewController
                                     withMode:(UIDatePickerMode)mode
                                    doneBlock:(WLCDatePickerDoneBlock)doneBlock
                                  cancelBlock:(void(^)(void))cancelBlock
{
    WLCDatePicker *datePicker = [WLCDatePicker wlcDatePicker];
    datePicker.datePicker.datePickerMode = mode;
    datePicker.doneBlock = doneBlock;
    datePicker.cancelBlock = cancelBlock;
    datePicker.datePicker.minimumDate = [NSDate date];
    
    UIView *controllerView = viewController.view;
    datePicker.frame = controllerView.bounds;
    [controllerView addSubview:datePicker];
    [datePicker show];
    
    return datePicker;
}

- (IBAction)onDoneButtonClicked:(id)sender
{
    [self dismiss];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (self.datePicker.datePickerMode == UIDatePickerModeTime) {
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    else if (self.datePicker.datePickerMode == UIDatePickerModeDate) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else if (self.datePicker.datePickerMode == UIDatePickerModeDateAndTime) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    NSString *strTime = [dateFormatter stringFromDate:self.datePicker.date];
    if (self.doneBlock) {
        self.doneBlock(strTime);
    }
}

- (IBAction)onCancelButtonClicked:(id)sender
{
    [self dismiss];
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

@end
