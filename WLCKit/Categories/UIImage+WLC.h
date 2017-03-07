//
//  UIImage+WLC.h
//  Training
//
//  Created by lichunwang on 16/12/28.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WLC)


/**
 判断图像是否带有alpha值

 @return YES表示有，否则无
 */
- (BOOL)hasAlphaChannel;


/**
 生成大小为（1，1）的color纯色图像

 @param color 图像的填充颜色

 @return 纯色图像
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 生成大小为size的color纯色图像
 
 @param color 图像的填充颜色
 @param size  图像大小
 
 @return 纯色图像
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 缩放图像

 @param size 缩放后的图像大小

 @return 缩放后的图像
 */
- (UIImage *)imageByResizeToSize:(CGSize)size;


/**
 根据图像数据获取图像的类型

 @param data 图像的数据

 @return 图像类型
 */
+ (NSInteger)imageTypeWithImageData:(NSData *)data;


/**
 解压图像

 @param image 待解压的图像

 @return 解压后的图像
 */
+ (UIImage *)decodeImage:(UIImage *)image;

@end
