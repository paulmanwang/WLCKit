//
//  UILabel+WLC.h
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/7/11.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WLC)

/**
 在限定width的情况下，计算label的size

 @param maxWidth label的最大宽度

 @return label的size
 */
- (CGSize)textSizeLimitedToMaxWidth:(CGFloat)maxWidth;

/**
 自动调整高度
 */
- (void)autoAdjustHeight;

@end
