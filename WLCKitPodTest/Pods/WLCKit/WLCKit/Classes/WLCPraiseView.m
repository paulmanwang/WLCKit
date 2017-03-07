//
//  WLCPraiseView.m
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/7/23.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCPraiseView.h"
#import "NSBundle+WLC.h"
#import "UIView+WLC.h"

@implementation WLCPraiseView

+ (instancetype)wlcPraiseView
{
    CGRect frame = CGRectMake(0, 0, 40, 40);
    WLCPraiseView *praiseView = [[WLCPraiseView alloc] initWithFrame:frame];
    if (praiseView) {
        [praiseView setupSubViews];
    }
    
    return praiseView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    [self clearSubviews];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imageView.image = [UIImage imageNamed:@"wlc_praise@2x" inBundle:[NSBundle wlcKitBundle] compatibleWithTraitCollection:nil];
    [self addSubview:imageView];
    self.praiseImageView = imageView;
    
    UIColor *blueColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(19, 3, 15, 8)];
    label.font = [UIFont boldSystemFontOfSize:8.0f];
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = blueColor;
    label.text = @"1";
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.numberLabel = label;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self addGestureRecognizer:tapGesture];
}

- (void)onTap
{
    NSLog(@"onTap");
    NSLog(@"number = %@", self.numberLabel.text);
    if (!self.enabled) {
        NSLog(@"禁止点击");
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(wlcPraiseViewDidClicked:)]) {
        [self.delegate wlcPraiseViewDidClicked:self];
    }
}

@end
