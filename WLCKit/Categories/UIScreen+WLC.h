//
//  UIScreen+WLC.h
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScreen (WLC)

/**
 屏幕的scale

 @return <#return value description#>
 */
+ (CGFloat)screenScale;


/**
 判断屏幕是否为窄屏

 @return 是否为窄屏
 */
+ (BOOL)isNarrowScreen;

@end
