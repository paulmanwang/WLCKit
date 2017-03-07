//
//  WLCSegmentedController.h
//  Training
//
//  Created by lichunwang on 16/12/29.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WLCSegmentedControllerType)
{
    WLCSegmentedControllerType_Top = 0,
    WLCSegmentedControllerType_Middle
};

@interface WLCSegmentedController : UIViewController

- (void)_init;

- (NSArray *)onConfigViewControllers;

+ (instancetype)instance;

@property (assign, nonatomic) BOOL scrollEnabled;

@end
