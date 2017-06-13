//
//  TCSegmentedControl.h
//  TimeCloud
//
//  Created by wanglichun on 15/7/9.
//  Copyright (c) 2015年 Xunlei. All rights reserved.
//  分段控件

#import <UIKit/UIKit.h>

@protocol WLCSegmentedControlDelegate <NSObject>

- (void)segmentedValueChanged:(id)sender;

@end

@interface WLCSegmentedControl : UIView

@property (weak, nonatomic) IBOutlet id<WLCSegmentedControlDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame segmentTitles:(NSArray *)titles;

@property (assign, nonatomic) NSInteger selectedSegmentIndex;

@property (assign, nonatomic) UIFont *titleFont; // the title font size, default is [UIFont systemFontOfSize:15.0]

@property (strong, nonatomic) UIColor *titleColor; // the title normal color, default is blackColor

@property (strong, nonatomic) UIColor *selectedTitleColor; // default is blueColor

@property (strong, nonatomic) UIColor *dividerColor; // default is blueColor

@property (assign, nonatomic) CGFloat dividerWidth; // default is 1.0f

@property (assign, nonatomic) CGFloat dividerHeight; // default is 20.0f

@property (assign, nonatomic) BOOL hideDivider; // default is NO

@property (assign, nonatomic) UIColor *indicatorColor; // default is blueColor

@property (assign, nonatomic) CGFloat indicatorWidth; // default is 60.0f

@property (assign, nonatomic) CGFloat indicatorHeight; // default is 2.0f

@property (assign, nonatomic) CGFloat indicatorBottomMargin; // default is 4.0f

@end
