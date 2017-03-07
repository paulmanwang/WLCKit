//
//  UIImageView+WLC.h
//  Training
//
//  Created by lichunwang on 17/1/11.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WLC)

- (void)roundCornerWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius cornerType:(UIRectCorner)cornerType;

- (void)roundCornerWithRadius:(CGFloat)radius conerType:(UIRectCorner)conerType;

- (void)triangleWithImage:(UIImage *)image;

@end
