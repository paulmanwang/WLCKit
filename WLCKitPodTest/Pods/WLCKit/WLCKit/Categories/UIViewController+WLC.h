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

- (void)presentViewControllerWithNavi:(UIViewController *)controller completion:(void(^)(void))completion;

@end
