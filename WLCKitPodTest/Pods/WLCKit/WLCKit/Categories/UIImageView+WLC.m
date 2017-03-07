//
//  UIImageView+WLC.m
//  Training
//
//  Created by lichunwang on 17/1/11.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "UIImageView+WLC.h"

@implementation UIImageView (WLC)

- (void)roundCornerWithImage:(UIImage *)image
                cornerRadius:(CGFloat)cornerRadius
                  cornerType:(UIRectCorner)cornerType
{
    CGSize size = self.bounds.size;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        UIGraphicsBeginImageContextWithOptions(size, NO, scale); // 第二个参数影响很大
        CGContextRef currentCotext = UIGraphicsGetCurrentContext();
        if (nil == currentCotext) {
            return;
        }
        
        // bezierpath是一种快速方式，也可以自己绘制四个圆弧
//        UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
//                                                         byRoundingCorners:cornerType
//                                                               cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
//        [cornerPath addClip];
        
        // 手动添加path
        CGFloat width = size.width;
        CGFloat height = size.height;
        CGFloat doubleRadius = 2 * cornerRadius;
        CGContextMoveToPoint(currentCotext, width, height-doubleRadius);  // 开始坐标右边开始
        CGContextAddArcToPoint(currentCotext, width, height, width-doubleRadius, height, cornerRadius);  // 右下角角度
        CGContextAddArcToPoint(currentCotext, 0, height, 0, height-doubleRadius, cornerRadius); // 左下角角度
        CGContextAddArcToPoint(currentCotext, 0, 0, width-doubleRadius, 0, cornerRadius); // 左上角
        CGContextAddArcToPoint(currentCotext, width, 0, width, height-doubleRadius, cornerRadius); // 右上角
        CGContextClosePath(currentCotext);
        CGContextClip(currentCotext);
        
        [image drawInRect:self.bounds];
        id processedImageRef = (__bridge id _Nullable)(UIGraphicsGetImageFromCurrentImageContext().CGImage);
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = processedImageRef;
        });
    });
}

- (void)roundCornerWithRadius:(CGFloat)radius
                    conerType:(UIRectCorner)conerType
{
    UIImage *image = self.image;
    if (image == nil) {
        NSAssert(image, @"image of imageview is nil");
        return;
    }
    
    [self roundCornerWithImage:image cornerRadius:radius cornerType:conerType];
}

- (void)triangleWithImage:(UIImage *)image
{
    CGSize size = self.bounds.size;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        if (nil == currentContext) {
            return;
        }
        
        // 绘制三角形
        CGPoint points[3];
        points[0] = CGPointMake(size.width / 2.0f, 0);
        points[1] = CGPointMake(size.width, size.height);
        points[2] = CGPointMake(0, size.height);
        CGContextAddLines(currentContext, points, 3);
        CGContextClosePath(currentContext);
        CGContextClip(currentContext);
        
        [image drawInRect:self.bounds];
        id processedImageRef = (__bridge id _Nullable)(UIGraphicsGetImageFromCurrentImageContext().CGImage);
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = processedImageRef;
        });
    });
}

@end
