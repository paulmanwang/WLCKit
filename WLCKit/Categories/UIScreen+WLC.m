//
//  UIScreen+WLC.m
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "UIScreen+WLC.h"

@implementation UIScreen (WLC)

+ (CGFloat)screenScale
{
    static CGFloat screenScale = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            screenScale = [[UIScreen mainScreen] scale];
        }
        else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                screenScale = [[UIScreen mainScreen] scale];
            });
        }
    });
    
    return screenScale;
}

+ (BOOL)isNarrowScreen
{
    static BOOL isNarrow = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        if (screenWidth < 375) {
            isNarrow = YES;
        }
    });
    
    return isNarrow;
}

@end
