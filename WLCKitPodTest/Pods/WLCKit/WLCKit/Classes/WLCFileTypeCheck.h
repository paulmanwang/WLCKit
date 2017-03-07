//
//  WLCFileTypeCheck.h
//  Training
//
//  Created by lichunwang on 17/1/12.
//  Copyright © 2017年 springcome. All rights reserved.
//  文件类型检测辅助类

#import <Foundation/Foundation.h>

@interface WLCFileTypeCheck : NSObject

+ (BOOL)checkImage:(NSString*)fileSuffix;

+ (BOOL)checkVideo:(NSString*)fileSuffix;

+ (BOOL)checkDocument:(NSString*)fileSuffix;

@end
