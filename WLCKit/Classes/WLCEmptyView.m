//
//  EmptyView.m
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/7/16.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCEmptyView.h"
#import <objc/runtime.h>
#import "UIView+WLC.h"
#import "NSBundle+WLC.h"

@implementation WLCEmptyView

+ (instancetype)showOnView:(UIView *)view withText:(NSString *)text icon:(NSString *)icon
{
    UIView *tmpView = [view subviewByTraversingWithCompareBlock:^BOOL(UIView *subView) {
        if ([subView isKindOfClass:[WLCEmptyView class]]) {
            return YES;
        }
        return NO;
    }];
    if (tmpView) {
        return nil;
    }
    
    WLCEmptyView *emptyView = (WLCEmptyView *)[[NSBundle wlcKitBundle] loadNibNamed:@"WLCEmptyView" owner:nil options:nil][0];
    emptyView.center = CGPointMake(view.width/2.0, view.height/2.0);
    emptyView.textLabel.text = text;
    emptyView.imageView.image = [UIImage imageNamed:icon];
    [view addSubview:emptyView];
    
    return emptyView;
}

@end

@implementation UIViewController (EmptyView)

static const char kEmptyViewKey = '\0';

- (void)setEmptyView:(WLCEmptyView *)emptyView
{
    objc_setAssociatedObject(self, &kEmptyViewKey, emptyView, OBJC_ASSOCIATION_ASSIGN); // 采用若引用就够了
}

- (WLCEmptyView *)emptyView
{
    return objc_getAssociatedObject(self, &kEmptyViewKey);
}

- (BOOL)alreadyHasEmptyVeiw
{
    UIView *view = [self.view subviewByTraversingWithCompareBlock:^BOOL(UIView *view) {
        if ([view isKindOfClass:[WLCEmptyView class]]) {
            NSLog(@"EmptyView已存在");
            return YES;
        }
        return NO;
    }];
    
    return view ? YES : NO;
}

- (void)showEmptyViewWithText:(NSString *)text icon:(NSString *)icon
{
    // 预防多个EmptyView叠加
    if ([self alreadyHasEmptyVeiw]) {
        return;
    }
    
    UIView *containerView = self.view;
    
    WLCEmptyView *emptyView = (WLCEmptyView *)[[NSBundle wlcKitBundle] loadNibNamed:@"WLCEmptyView" owner:nil options:nil][0];
    emptyView.center = CGPointMake(containerView.width/2.0, containerView.height/2.0);
    emptyView.textLabel.text = text;
    emptyView.imageView.image = [UIImage imageNamed:icon];
    [containerView addSubview:emptyView];
    
    [self setEmptyView:emptyView];
}

//- (void)dismissEmptyView
//{
//    WLCEmptyView *emptyView = [self emptyView];
//    [emptyView removeFromSuperview];
//    emptyView = nil;
//}

// 这种循环查找的效率太慢
- (void)dismissEmptyView
{
    UIView *emptyView = [self.view subviewByTraversingWithCompareBlock:^BOOL(UIView *view) {
        if ([view isKindOfClass:[WLCEmptyView class]]) {
            return YES;
        }
        
        return NO;
    }];
    
    if (emptyView) {
        [emptyView removeFromSuperview];
        emptyView.hidden = YES; // 卧槽有BUG
        emptyView = nil;
    }
}

@end
