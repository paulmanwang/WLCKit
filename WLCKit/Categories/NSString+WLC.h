//
//  NSString+WLC.h
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/23.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WLC)

/**
 字典转化为json格式的字符串

 @param dic 字典

 @return json格式字符串
 */
- (NSString *)stringWithDictionary:(NSDictionary *)dic;

/**
 将json格式的字符串转换为字典

 @return 字典
 */
- (NSDictionary *)toDictionary;

@end
