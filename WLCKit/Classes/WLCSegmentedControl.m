//
//  TCSegmentedControl.m
//  TimeCloud
//
//  Created by wanglichun on 15/7/9.
//  Copyright (c) 2015年 Xunlei. All rights reserved.
//

#import "WLCSegmentedControl.h"
#import "UIView+WLC.h"

@interface WLCSegmentedControl()

@property (copy, nonatomic) NSArray *segmentTitles;
@property (strong, nonatomic) NSMutableArray *segmentBtns;
@property (strong, nonatomic) UIImageView *sliderImageView;
@property (strong, nonatomic) NSMutableArray *dividerImageViews;

@property (assign, nonatomic) BOOL animated;

@end

@implementation WLCSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    
    return self;
}

- (void)_init
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    // 初始化默认值
    _dividerWidth       = 1.0f;
    _dividerHeight      = 20.0f;
    _sliderHeight       = 1.5f;
    _sliderWidth        = 80.0f;
    _sliderBottomMargin = 2.0f;
    
    _sliderColor       = [UIColor whiteColor];
    _dividerColor      = [UIColor whiteColor];
    _fontColor         = [UIColor whiteColor];
    _selectedFontColor = [UIColor whiteColor];
    _fontSize     = 16.0f;
    
    _selectedSegmentIndex = 0;
}

- (void)setTitles:(NSArray *)titles
{
    [self clearSubviews];
    if (titles.count == 0) {
        return ;
    }
    
    self.segmentTitles = titles;
    self.segmentBtns = [[NSMutableArray alloc] init];
    self.dividerImageViews = [[NSMutableArray alloc] init];

    for (NSInteger i = 0; i < titles.count; i++) {
        // 按钮
        UIButton *segmentBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        // default is NO. if YES, show a simple feedback (currently a glow) while highlighted
        segmentBtn.showsTouchWhenHighlighted = YES;
        UIColor *fontColor = i == self.selectedSegmentIndex ? _selectedFontColor : _fontColor;
        [self addSubview:segmentBtn];
        [segmentBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:titles[i]
                                                                       attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize],
                                                                                    NSForegroundColorAttributeName:fontColor}]
                              forState:UIControlStateNormal];
        segmentBtn.tag = i;
        [segmentBtn addTarget:self action:@selector(onSegmentClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.segmentBtns addObject:segmentBtn];
        
        // 分割线
        UIImageView *dividerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        dividerImageView.backgroundColor = self.dividerColor;
        [self addSubview:dividerImageView];
        
        [self.dividerImageViews addObject:dividerImageView];
    }
    
    // 底部滑动图片
    self.sliderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.sliderImageView.backgroundColor = self.sliderColor;
    [self addSubview:self.sliderImageView];
}

- (void)updateFrameOfSlider
{
    NSInteger segmentCount = self.segmentTitles.count;
    CGFloat segmentWidth = self.width / segmentCount;
    CGFloat halfSegmentWidth = segmentWidth / 2;
    CGFloat x = self.selectedSegmentIndex * segmentWidth + halfSegmentWidth - self.sliderWidth / 2;
    CGFloat y = self.height - self.sliderHeight - self.sliderBottomMargin;
    self.sliderImageView.frame = CGRectMake(x, y, self.sliderWidth, self.sliderHeight);
}

- (void)updateFrameOfSubViews
{
    NSInteger segmentCount = self.segmentTitles.count;
    CGFloat segmentBtnWidth = (self.width - (segmentCount - 1) * self.dividerWidth) / segmentCount;
    CGFloat segmentBtnHeight = self.height/*扩大触碰区域，不用减去后面这些了！ - self.sliderHeight - self.sliderBottomMargin*/;
    
    for (NSInteger i = 0; i < segmentCount; i++) {
        UIButton *btn = self.segmentBtns[i];
        btn.frame = CGRectMake(i * (segmentBtnWidth + self.dividerWidth), 0, segmentBtnWidth, segmentBtnHeight);
        
        UIImageView *imageView = self.dividerImageViews[i];
        imageView.frame = CGRectMake((i + 1) * segmentBtnWidth + i * self.dividerWidth,
                                     (self.height - self.dividerHeight) / 2,
                                     self.dividerWidth, self.dividerHeight);
    }
    
    if (_animated) {
        [UIView animateWithDuration:0.3 animations:^{
            [self updateFrameOfSlider];
        } completion:^(BOOL finished) {
            _animated = NO;
        }];
    }
    else {
        [self updateFrameOfSlider];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateFrameOfSubViews];
}

- (void)onSegmentClicked:(id)sender
{
    UIButton *segmentBtn = (UIButton *)sender;
    if (self.selectedSegmentIndex == segmentBtn.tag) {
        return;
    }
    self.selectedSegmentIndex = segmentBtn.tag;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self updateFrameOfSlider];
    }];
    
    if ([self.delegate respondsToSelector:@selector(segmentedValueChanged:)]) {
        [self.delegate segmentedValueChanged:self];
    }
}

#pragma mark - Setter

- (void)updateButton:(UIButton *)button withFontSize:(CGFloat)fontSize fontColor:(UIColor *)fontColor
{
    [button setAttributedTitle:[[NSAttributedString alloc] initWithString:button.titleLabel.text
                                                                   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                                                                NSForegroundColorAttributeName:fontColor}]
                          forState:UIControlStateNormal];
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    
    for (UIButton *button in self.segmentBtns) {
        // button.titleLabel.font = [UIFont systemFontOfSize:fontSize]; // 无效
        [self updateButton:button withFontSize:_fontSize fontColor:_fontColor];
    }
}

- (void)setFontColor:(UIColor *)fontColor
{
    _fontColor = fontColor;
    
    for (UIButton *button in self.segmentBtns) {
        // button.titleLabel.textColor = fontColor; // 无效
        [self updateButton:button withFontSize:_fontSize fontColor:_fontColor];
    }
}

- (void)setSelectedFontColor:(UIColor *)selectedFontColor
{
    _selectedFontColor = selectedFontColor;
    
    for (NSInteger i = 0; i < self.segmentBtns.count; i++) {
        UIColor *color = nil;
        if (i == self.selectedSegmentIndex) {
            color = _selectedFontColor;
        }
        else {
            color = _fontColor;
        }
        
        UIButton *button = self.segmentBtns[i];
        [self updateButton:button withFontSize:_fontSize fontColor:color];
    }
}

- (void)setDividerColor:(UIColor *)dividerColor
{
    _dividerColor = dividerColor;
    
    for (UIView *view in self.dividerImageViews) {
        view.backgroundColor = dividerColor;
    }
}

- (void)setSliderColor:(UIColor *)sliderColor
{
    _sliderColor = sliderColor;
    
    self.sliderImageView.backgroundColor = sliderColor;
}

- (void)setHideDivider:(BOOL)hideDivider
{
    for (UIView *view in self.dividerImageViews) {
        view.hidden = hideDivider;
    }
}

- (void)setSliderWidth:(CGFloat)sliderWidth
{
    _sliderWidth = sliderWidth;
    [self setNeedsLayout];
}

- (void)setSliderHeight:(CGFloat)sliderHeight
{
    _sliderHeight = sliderHeight;
    [self setNeedsLayout];
}

- (void)setSliderBottomMargin:(CGFloat)sliderBottomMargin
{
    _sliderBottomMargin = sliderBottomMargin;
    [self setNeedsLayout];
}

- (void)setDividerWidth:(CGFloat)dividerWidth
{
    _dividerWidth = dividerWidth;
    [self setNeedsLayout];
}

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex
{
    _selectedSegmentIndex = selectedSegmentIndex;
    _animated = YES;
    [self setSelectedFontColor:_selectedFontColor];
    [self setNeedsLayout];
}

@end
