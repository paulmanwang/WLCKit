//
//  UIColor+WLC.m
//  MyDemos
//
//  Created by lichunwang on 16/12/12.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "UIColor+WLC.h"

@implementation UIColor (WLC)

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    return [self colorWithHexString:hexString alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (hexString.length == 0) {
        return [UIColor whiteColor];
    }
    
    if ([hexString containsString:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    NSString *redString = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *greenString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *blueString = [hexString substringWithRange:NSMakeRange(4, 2)];
    
    unsigned int r, g, b;
    [[[NSScanner alloc] initWithString:redString] scanHexInt:&r];
    [[[NSScanner alloc] initWithString:greenString] scanHexInt:&g];
    [[[NSScanner alloc] initWithString:blueString] scanHexInt:&b];
    
    return [UIColor colorWithRed:r/255.0f green:g/255.00f blue:b/255.00f alpha:alpha];
}

+ (UIColor *)randomColor
{
    srand([[NSDate date] timeIntervalSince1970]);
    return [UIColor color255WithRed:abs(rand()%256) green:abs(rand()%256) blue:abs(rand()%256)];
}

+ (UIColor *)color255WithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)color255WithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
}

@end
