//
//  UIView+WLC.m
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/6/28.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "UIView+WLC.h"
#import <objc/runtime.h>

static const char tapKey;

@implementation UIView (WLC)

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setTop:(CGFloat)top
{
    CGRect rect = self.frame;
    rect.origin.y = top;
    self.frame = rect;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setPosition:(CGPoint)position
{
    CGRect rect = self.frame;
    self.frame = CGRectMake(position.x, position.y, rect.size.width, rect.size.height);
}

- (CGPoint)position
{
    return self.frame.origin;
}

- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height);
}
- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left
{
    CGRect rect = self.frame;
    self.frame = CGRectMake(left, rect.origin.y, rect.size.width, rect.size.height);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect rect = self.frame;
    self.frame = CGRectMake(right - rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
}

- (CGFloat)bottom
{
    CGRect rect = self.frame;
    return rect.origin.y + rect.size.height;
}
- (void)setBottom:(CGFloat)bottom
{
    CGRect rect = self.frame;
    self.frame = CGRectMake(rect.origin.x, bottom - rect.size.height, rect.size.width, rect.size.height);
}

- (CGFloat)screenX
{
    CGFloat x = 0;
    for (UIView *view = self; view; view = view.superview) {
        x += view.left;
    }
    
    return x;
}

- (CGFloat)screenY
{
    CGFloat y = 0;
    for (UIView *view = self; view; view = view.superview) {
        y += view.top;
    }
    
    return y;
}

- (UIViewController *)viewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)nextResponder;
    }
    else {
        return nil;
    }
}

- (UIImage *)snapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer drawInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    return image;
}

- (void)clearSubviews
{
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

+ (instancetype)viewWithNib:(NSString *)nib owner:(id)owner
{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:owner options:nil][0];
}

- (void)addTapGestureWithAction:(void(^)(void))actionBlock
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    objc_setAssociatedObject(self, &tapKey, [actionBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tapGesture];
}

- (void)onTap:(UIGestureRecognizer *)tapGesture
{
    void(^tapBlock)(void) = objc_getAssociatedObject(self, &tapKey);
    if (tapBlock) {
        tapBlock();
    }
}

- (void)roundWithCornerRadius:(CGFloat)cornerRadius
{
    // 效率很低，影响界面的流畅
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES; // 这里会造成离屏渲染
}

// 跟上面的方法一样，效率很低
- (void)setRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius
{
    CGRect rect = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                           byRoundingCorners:corners
                                                 cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = rect;
    maskLayer.path = path.CGPath;
    
    self.layer.mask = maskLayer; // 这里会造成离屏渲染
}

- (UIView *)subviewWithCompareBlock:(BOOL (^)(UIView *))compareBlock
{
    for (UIView *subview in self.subviews) {
        if (compareBlock(subview)) {
            return subview;
        }
    }
    
    return nil;
}

- (UIView *)subviewByTraversingWithCompareBlock:(BOOL(^)(UIView *view))compareBlock
{
    for (UIView *subview in self.subviews) {
        if (compareBlock(subview)) {
            return subview;
        }
        else {
            UIView *tmpView = [subview subviewByTraversingWithCompareBlock:compareBlock];
            if (tmpView) {
                return tmpView;
            }
        }
    }
    
    return nil;
}

- (UIView *)superviewWithCompareBlock:(BOOL(^)(UIView *view))compareBlock
{
    UIView *superView = self.superview;
    while (superView) {
        if (compareBlock(superView)) {
            return superView;
        }
        
        superView = superView.superview;
    }
    
    return nil;
}

- (void)traverseSubViewWithBlock:(void(^)(UIView *view))block
{
    if (block == nil) {
        return;
    }
    
    for (UIView *subview in self.subviews) {
//        if ([subview isKindOfClass:[UISearchBar class]]) {
//            continue;
//        }
        NSLog(@"class of subview is = %@", NSStringFromClass([subview class]));
        block(subview);
        [subview traverseSubViewWithBlock:block];
    }
}

@end
