//
//  WLCDatePicker.h
//  Training
//
//  Created by lichunwang on 16/12/21.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WLCDatePickerDoneBlock)(NSString *timeString);

@interface WLCDatePicker : UIView

@property (copy, nonatomic) WLCDatePickerDoneBlock doneBlock;
@property (copy, nonatomic) dispatch_block_t cancelBlock;

+ (instancetype)wlcDatePicker;

+ (instancetype)showDatePickerOnViewContoller:(UIViewController *)viewController
                                     withMode:(UIDatePickerMode)mode
                                    doneBlock:(WLCDatePickerDoneBlock)doneBlock
                                  cancelBlock:(void(^)(void))cancelBlock;

@end
