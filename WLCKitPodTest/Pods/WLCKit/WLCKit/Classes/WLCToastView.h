//
//  WLCToastView.h
//  Training
//
//  Created by lichunwang on 16/12/22.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCToastView : UIView

+ (UIWindow *)topWindow;

+ (void)toastWithMessage:(NSString *)message;

+ (void)toastWithMessage:(NSString *)message error:(NSError *)error;

@end
