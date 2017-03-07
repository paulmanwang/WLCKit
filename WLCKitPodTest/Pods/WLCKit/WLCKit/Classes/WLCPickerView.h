//
//  WLCDatePicker.h
//  Training
//
//  Created by lichunwang on 16/12/21.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WLCPickViewDoneBlock)(NSInteger selectedIndex);

@interface WLCPickerView : UIView

@property (copy, nonatomic) WLCPickViewDoneBlock doneBlock;
@property (copy, nonatomic) dispatch_block_t cancelBlock;

+ (instancetype)wlcPickerView;

+ (instancetype)showPickerViewOnViewController:(UIViewController *)viewController
                                  withDataList:(NSArray *)dataList
                                 selectedIndex:(NSInteger)selectedIndex
                                     doneBlock:(void(^)(NSInteger selectedIndex))doneBlock
                                   cancelBlock:(void(^)(void))cancelBlock;


@end
