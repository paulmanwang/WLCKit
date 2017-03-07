//
//  CALayer+WLC.h
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/20.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CALayer (WLC)

@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGPoint center;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGFloat transformRotation;
@property (assign, nonatomic) CGFloat transformRotationX;
@property (assign, nonatomic) CGFloat transformRotationY;
@property (assign, nonatomic) CGFloat transfromRotationZ;
@property (assign, nonatomic) CGFloat transformScale;
@property (assign, nonatomic) CGFloat transformScaleX;
@property (assign, nonatomic) CGFloat transformScaleY;
@property (assign, nonatomic) CGFloat transformScaleZ;
@property (assign, nonatomic) CGFloat transformTranslationX;
@property (assign, nonatomic) CGFloat transformTranslationY;
@property (assign, nonatomic) CGFloat transformTranslationZ;


/**
 生成快照图像

 @return 快照图像
 */
- (UIImage *)snapshotImage;


/**
 移除所有子layers
 */
- (void)removeAllSublayers;


/**
 设置图层的阴影效果

 @param color  阴影颜色
 @param offset 阴影偏移量
 @param radius 阴影半径
 */
- (void)setShadowWithColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

@end
