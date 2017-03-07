//
//  WLCCommentView.m
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/7/23.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCCommentView.h"
#import "NSBundle+WLC.h"
#import "UIView+WLC.h"

@implementation WLCCommentView

+ (instancetype)wlcCommentView
{
    CGRect frame = CGRectMake(0, 0, 40, 40);
    WLCCommentView *commentView = [[WLCCommentView alloc] initWithFrame:frame];
    if (commentView) {
        commentView.backgroundColor = [UIColor clearColor];
        [commentView setupSubviews];
    }
    
    return commentView;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    [self setupSubviews];
}

- (void)setupSubviews
{
    [self clearSubviews];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 23, 25)];
    imageView.image = [UIImage imageNamed:@"comment@2x" inBundle:[NSBundle wlcKitBundle] compatibleWithTraitCollection:nil];
    [self addSubview:imageView];
    self.commentImageView = imageView;
    
    UIColor *blueColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12, 19, 15, 8)];
    label.textColor = [UIColor darkGrayColor];
    label.backgroundColor = blueColor;
    label.font = [UIFont boldSystemFontOfSize:8.0f];
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
    if ([self.delegate respondsToSelector:@selector(wlcCommentViewDidClicked:)]) {
        [self.delegate wlcCommentViewDidClicked:self];
    }
}

@end
