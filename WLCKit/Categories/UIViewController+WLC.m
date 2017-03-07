//
//  UIViewController+WLC.m
//  Training
//
//  Created by lichunwang on 16/12/30.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "UIViewController+WLC.h"
#import <objc/runtime.h>

static const char kTempNaviControllerKey = '\0';

// 思考继承和扩展http://blog.csdn.net/openglnewbee/article/details/51133340
@implementation UIViewController (WLC)

- (void)presentViewControllerWithNavi:(UIViewController *)controller
                           completion:(void(^)(void))completion
{
    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:controller];
    controller.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_close_btn"] style:UIBarButtonItemStylePlain target:self action:@selector(onCloseBtnClicked)];

    [self setTempNaviController:naviController];
    [self presentViewController:naviController animated:YES completion:completion];
}

- (void)setTempNaviController:(UINavigationController *)naviController
{
    objc_setAssociatedObject(self, &kTempNaviControllerKey, naviController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)onCloseBtnClicked
{
    UINavigationController *naviController = objc_getAssociatedObject(self, &kTempNaviControllerKey);
    [naviController dismissViewControllerAnimated:YES completion:nil];
    objc_setAssociatedObject(self, &kTempNaviControllerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
