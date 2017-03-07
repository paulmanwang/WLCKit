//
//  CALayer+WLC.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/20.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "CALayer+WLC.h"

@implementation CALayer (WLC)

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGPoint)center
{
    return CGPointMake(self.left + self.width * 0.5, self.top + self.height * 0.5);
}

- (CGFloat)centerX
{
    return self.left + self.width * 0.5;
}

- (CGFloat)centerY
{
    return self.top + self.height * 0.5;
}

- (void)setTop:(CGFloat)top
{
    CGRect frame = CGRectMake(self.left, top, self.width, self.height);
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = CGRectMake(self.left, bottom - self.height, self.width, self.height);
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left
{
    CGRect frame = CGRectMake(left, self.top, self.width, self.height);
    self.frame = frame;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = CGRectMake(right - self.width, self.top, self.width, self.height);
    self.frame = frame;
}

- (void)setCenter:(CGPoint)center
{
    CGRect frame = CGRectMake(center.x - self.width * 0.5,
                              center.y - self.height * 0.5,
                              self.width,
                              self.height);
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGRect frame = CGRectMake(centerX - self.width * 0.5, self.top, self.width, self.height);
    self.frame = frame;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGRect frame = CGRectMake(self.left, centerY - self.height * 0.5, self.width, self.height);
    self.frame = frame;
}

- (CGFloat)transformRotation
{
    NSNumber *value = [self valueForKey:@"transform.rotation"];
    return value.doubleValue;
}

- (void)setTransformRotation:(CGFloat)transformRotation
{
    [self setValue:@(transformRotation) forKey:@"transform.rotation"];
}

- (CGFloat)transformRotationX
{
    NSNumber *value = [self valueForKey:@"transform.rotation.x"];
    return value.doubleValue;
}

- (void)setTransformRotationX:(CGFloat)transformRotationX
{
    [self setValue:@(transformRotationX) forKey:@"transform.rotation.x"];
}

- (CGFloat)transformRotationY
{
    NSNumber *value = [self valueForKey:@"transform.rotation.y"];
    return value.doubleValue;
}

- (void)setTransformRotationY:(CGFloat)transformRotationY
{
    [self setValue:@(transformRotationY) forKey:@"transform.rotation.y"];
}

- (CGFloat)transformRotationZ
{
    NSNumber *value = [self valueForKey:@"transform.rotation.z"];
    return value.doubleValue;
}

- (void)setTransformRotationZ:(CGFloat)transformRotationZ
{
    [self setValue:@(transformRotationZ) forKey:@"transform.rotation.z"];
}

- (CGFloat)transformScale
{
    NSNumber *value = [self valueForKey:@"transform.scale"];
    return value.doubleValue;
}

- (void)setTransformScale:(CGFloat)transformScale
{
    [self setValue:@(transformScale) forKey:@"transform.scale"];
}

- (CGFloat)transformScaleX
{
    NSNumber *value = [self valueForKey:@"transform.scale.x"];
    return value.doubleValue;
}

- (void)setTransformScaleX:(CGFloat)transformScaleX
{
    [self setValue:@(transformScaleX) forKey:@"transform.scale.x"];
}

- (CGFloat)transformScaleY
{
    NSNumber *value = [self valueForKey:@"transform.scale.y"];
    return value.doubleValue;
}

- (void)setTransformScaleY:(CGFloat)transformScaleY
{
    [self setValue:@(transformScaleY) forKey:@"transform.scale.y"];
}

- (CGFloat)transformScaleZ
{
    NSNumber *value = [self valueForKey:@"transform.scale.z"];
    return value.doubleValue;
}

- (void)setTransformScaleZ:(CGFloat)transformScaleZ
{
    [self setValue:@(transformScaleZ) forKey:@"transform.scale.z"];
}

- (CGFloat)transformTranslationX
{
    NSNumber *value = [self valueForKey:@"transform.translation.x"];
    return value.doubleValue;
}

- (void)setTransformTranslationX:(CGFloat)transformTranslationX
{
    [self setValue:@(transformTranslationX) forKey:@"transform.translation.x"];
}

- (CGFloat)transformTranslationY
{
    NSNumber *value = [self valueForKey:@"transform.translation.y"];
    return value.doubleValue;
}

- (void)setTransformTranslationY:(CGFloat)transformTranslationY
{
    [self setValue:@(transformTranslationY) forKey:@"transform.translation.y"];
}

- (CGFloat)transformTranslationZ
{
    NSNumber *value = [self valueForKey:@"transform.translation.z"];
    return value.doubleValue;
}

- (void)setTransformTranslationZ:(CGFloat)transformTranslationZ
{
    [self setValue:@(transformTranslationZ) forKey:@"transform.translation.z"];
}

- (UIImage *)snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

- (void)removeAllSublayers
{
    while (self.sublayers.count) {
        [self.sublayers.lastObject removeFromSuperlayer];
    }
}

- (void)setShadowWithColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius
{
    self.shadowColor = color.CGColor;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.opacity = 1;
    self.shouldRasterize = YES;
    self.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
