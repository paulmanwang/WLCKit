//
//  UIButton+WLC.m
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/7/11.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "UIButton+WLC.h"
#import <objc/runtime.h>

static const char tapBlockKey = '\0';

@implementation UIButton (WLC)

- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateSelected];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateDisabled];
}

- (NSString *)title
{
    return [self titleForState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                     tapBlock:(void(^)(void))callBackBlock
{
    self = [super initWithFrame:frame];
    self.title = title;
    [self setTapBlock:callBackBlock];
    [self addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

- (void)setTapBlock:(void(^)(void))callBackBlock
{
    // 关联对象对block是否是强引用
    objc_setAssociatedObject(self, &tapBlockKey, [callBackBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)onTap
{
    void(^tapBlock)(void) = objc_getAssociatedObject(self, &tapBlockKey);
    if (tapBlock) {
        tapBlock();
    }
}

- (void)addAction:(void (^)(void))actionBlock
{
    [self addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    objc_setAssociatedObject(self, &tapBlockKey, [actionBlock copy], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
