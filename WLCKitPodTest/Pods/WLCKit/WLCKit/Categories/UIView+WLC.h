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


/**
 生成快照图像

 @return 快照图像
 */
- (UIImage *)snapshotImage;


/**
 清除所有子视图
 */
- (void)clearSubviews;

/**
 通过xib获取视图

 @param nib   xib名称
 @param owner xib的owner

 @return 视图实例
 */
+ (instancetype)viewWithNib:(NSString *)nib owner:(id)owner;


/**
 给视图快速添加tap手势

 @param actionBlock tap手势的回调block
 */
- (void)addTapGestureWithAction:(void(^)(void))actionBlock;

/**
 设置圆角

 @param cornerRadius 圆角度
 */
- (void)roundWithCornerRadius:(CGFloat)cornerRadius;


/**
 设置圆角

 @param corners 设置哪些角需要添加圆角效果
 @param radius  圆角度
 */
- (void)setRoundCorners:(UIRectCorner)corners radius:(CGFloat)radius;


/**
 遍历所有子视图

 @param block 子视图的操作block
 */
- (void)traverseSubViewWithBlock:(void(^)(UIView *subView))block;

#pragma mark - search

/**
 寻找符合条件的子视图，只查找一层子视图

 @param compareBlock 条件block

 @return 符合条件的子视图
 */
- (UIView *)subviewWithCompareBlock:(BOOL(^)(UIView *view))compareBlock;


/**
 寻找符合条件的子视图，遍历查找所有的子视图

 @param compareBlock 条件block

 @return 符合条件的子视图
 */
- (UIView *)subviewByTraversingWithCompareBlock:(BOOL(^)(UIView *view))compareBlock;

/**
 选择符合条件的父视图

 @param compareBlock 添加block

 @return 符合条件的父视图
 */
- (UIView *)superviewWithCompareBlock:(BOOL(^)(UIView *view))compareBlock;

@end
