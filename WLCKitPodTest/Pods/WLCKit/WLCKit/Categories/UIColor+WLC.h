//
//  UIColor+WLC.h
//  MyDemos
//
//  Created by lichunwang on 16/12/12.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WLC)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

+ (UIColor *)color255WithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha;

+ (UIColor *)color255WithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue;

@end
