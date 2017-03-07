//
//  UIImageView+WLC.h
//  Training
//
//  Created by lichunwang on 17/1/11.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WLC)

/**
 生成圆角图像

 @param image        原始图像
 @param cornerRadius 圆角度
 @param cornerType   需要有圆角效果的corners
 */
- (void)roundCornerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius cornerType:(UIRectCorner)cornerType;

/**
 生成圆角图像
 
 @param radius        原始图像
 @param cornerType   需要有圆角效果的corners
 */
- (void)roundCornerWithRadius:(CGFloat)radius cornerType:(UIRectCorner)cornerType;

/**
 生成三角图像

 @param image 原始图像
 */
- (void)triangleWithImage:(UIImage *)image;

@end
