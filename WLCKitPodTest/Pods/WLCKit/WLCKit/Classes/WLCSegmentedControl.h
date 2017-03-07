//
//  TCSegmentedControl.h
//  TimeCloud
//
//  Created by wanglichun on 15/7/9.
//  Copyright (c) 2015年 Xunlei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLCSegmentedControlDelegate <NSObject>

- (void)segmentedValueChanged:(id)sender;

@end

@interface WLCSegmentedControl : UIView

@property (weak, nonatomic) IBOutlet id<WLCSegmentedControlDelegate> delegate;
@property (strong, nonatomic) NSArray *titles;
@property (assign, nonatomic) NSInteger selectedSegmentIndex;

@property (assign, nonatomic) CGFloat fontSize; // default is 16.0f
@property (strong, nonatomic) UIColor *fontColor; // default is whiteColor
@property (strong, nonatomic) UIColor *selectedFontColor; // default is whiteColor
@property (strong, nonatomic) UIColor *dividerColor; // default is whiteColor
@property (assign, nonatomic) UIColor *sliderColor; // default is whiteColor

@property (assign, nonatomic) CGFloat sliderWidth; // default is 60.0f
@property (assign, nonatomic) CGFloat sliderHeight; // default is 2.0f
@property (assign, nonatomic) CGFloat sliderBottomMargin; // default is 4.0f
@property (assign, nonatomic) CGFloat dividerWidth; // default is 1.0f
@property (assign, nonatomic) CGFloat dividerHeight; // default is 20.0f

@property (assign, nonatomic) BOOL hideDivider; // default is NO

@end
