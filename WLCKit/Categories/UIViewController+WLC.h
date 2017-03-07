//
//  UIViewController+WLC.h
//  Training
//
//  Created by lichunwang on 16/12/30.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WLC)

// 模仿sunnyxx
// @property (assign, nonatomic) BOOL prefersNavigationBarHidden;

/**
 用一个NavigatinController包裹模态展示一个ViewController

 @param controller 待展示的ViewController
 @param completion 展示完成的回调block
 */
- (void)presentViewControllerWithNavi:(UIViewController *)controller completion:(void(^)(void))completion;

@end
