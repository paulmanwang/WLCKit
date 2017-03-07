//
//  WLCReflection.h
//  WLCKitDemo
//
//  Created by lichunwang on 17/3/1.
//  Copyright © 2017年 springcome. All rights reserved.
//  反射辅助类

#import <Foundation/Foundation.h>

@interface WLCReflection : NSObject

/**
 根据属性名称获取该属性类型

 @param classType    属性所在的类
 @param propertyName 属性名称

 @return 属性类型
 */
+ (NSString *)propertyTypeOfClass:(Class)classType propertyName:(NSString *)propertyName;


/**
 获取Class的所有属性名称

 @param classType 类

 @return 类的属性列表
 */
+ (NSArray *)getAllPropertyNamesOfClass:(Class)classType;

@end
