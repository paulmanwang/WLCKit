//
//  NSBundle+WLC.h
//  Training
//
//  Created by lichunwang on 17/2/7.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (WLC)

+ (NSString *)appName;

+ (NSString *)appVersion;

+ (NSString *)appBuildVersion;

+ (NSBundle *)wlcKitBundle;

@end
