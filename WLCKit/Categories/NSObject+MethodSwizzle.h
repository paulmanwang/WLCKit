//
//  NSObject+MethodSwizzle.h
//  MyDemos
//
//  Created by lichunwang on 16/12/8.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzle)

+ (BOOL)exchangeInstanceMethod:(SEL)originalSelector withNewInstanceMethod:(SEL)newSelector;

+ (BOOL)exchangeClassMethod:(SEL)originalSelector withNewClassMethod:(SEL)newSelector;

@end
