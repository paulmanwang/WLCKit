//
//  WLCOnePixelHeightView.m
//  Training
//
//  Created by lichunwang on 16/12/21.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCOnePixelView.h"
#import "UIView+WLC.h"

@implementation WLCOnePixelHeightView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat onePixelHeight = 1 / scale;
    
    self.height = onePixelHeight;
}

@end

@implementation WLCOnePixelWidthView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat onePixelWidth = 1 / scale;
    
    self.width = onePixelWidth;
}

@end
