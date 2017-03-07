//
//  WLCDatePicker.m
//  Training
//
//  Created by lichunwang on 16/12/21.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCPickerView.h"
#import "UIView+WLC.h"
#import "NSBundle+WLC.h"

static NSMutableDictionary *datePickerDic;

@interface WLCPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (copy, nonatomic) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation WLCPickerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self addGestureRecognizer:tapGesture];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
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
    if (self == [WLCPickerView class]) {
        datePickerDic = [NSMutableDictionary new];
    }
}

+ (instancetype)wlcPickerView
{
    return (WLCPickerView *)[[NSBundle wlcKitBundle] loadNibNamed:@"WLCPickerView" owner:nil options:nil][0];
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

+ (instancetype)showPickerViewOnViewController:(UIViewController *)viewController
                                  withDataList:(NSArray *)dataList
                                 selectedIndex:(NSInteger)selectedIndex
                                     doneBlock:(void(^)(NSInteger selectedIndex))doneBlock
                                   cancelBlock:(void(^)(void))cancelBlock
{
    WLCPickerView *pickerView = [WLCPickerView wlcPickerView];
    pickerView.doneBlock = doneBlock;
    pickerView.cancelBlock = cancelBlock;
    pickerView.dataList = dataList;
    [pickerView.pickerView selectRow:selectedIndex inComponent:0 animated:NO];
    
    UIView *controllerView = viewController.view;
    pickerView.frame = controllerView.bounds;
    [controllerView addSubview:pickerView];
    [pickerView show];
    
    return pickerView;
}

- (IBAction)onDoneButtonClicked:(id)sender
{
    [self dismiss];
    
    NSInteger selectedIndex = [self.pickerView selectedRowInComponent:0];
    if (self.doneBlock) {
        self.doneBlock(selectedIndex);
    }
}

- (IBAction)onCancelButtonClicked:(id)sender
{
    [self dismiss];
    
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataList.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = self.dataList[row];

    return [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f], NSForegroundColorAttributeName:[UIColor blackColor]}];
}

@end
