//
//  UIView+WLC.h
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/6/28.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WLC)

#define UIViewAutoresizingAll (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGPoint position;
@property (assign, nonatomic) CGSize size;

@property (readonly, nonatomic) CGFloat screenX;
@property (readonly, nonatomic) CGFloat screenY;

@property (readonly, nonatomic) UIViewController *viewController;

- (UIImage *)snapshotImage;

- (void)clearSubviews;

+ (instancetype)viewWithNib:(NSString *)nib owner:(id)owner;

- (void)addTapGestureWithAction:(void(^)(void))actionBlock;

- (void)roundWithCornerRadius:(CGFloat)cornerRadius;

- (void)setRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;

- (void)traverseSubViewWithBlock:(void(^)(UIView *subView))block;

#pragma mark - search

- (UIView *)subviewWithCompareBlock:(BOOL(^)(UIView *view))compareBlock;

- (UIView *)subviewByTraversingWithCompareBlock:(BOOL(^)(UIView *view))compareBlock;

- (UIView *)superviewWithCompareBlock:(BOOL(^)(UIView *view))compareBlock;

@end
