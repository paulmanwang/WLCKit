//
//  WLCStack.h
//  MyDemos
//
//  Created by lichunwang on 16/12/9.
//  Copyright © 2016年 springcome. All rights reserved.
//  7种方法实现的线程安全的stack

#import <Foundation/Foundation.h>

@interface WLCStack : NSObject

// v1 dispatch_semaphore_t实现
- (void)push:(id)anObject;
- (id)pop;
- (BOOL)isEmpty;
- (void)enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block;

// v2 lock实现
- (void)v2_push:(id)anObject;
- (id)v2_pop;
- (BOOL)v2_isEmpty;
- (void)v2_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block;

// v3 dispatch_barrier_async+concurent dispatch queue实现
- (void)v3_push:(id)anObject;
- (id)v3_pop;
- (BOOL)v3_isEmpty;
- (void)v3_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block;

// v4 serial dispatch queue实现
- (void)v4_push:(id)anObject;
- (id)v4_pop;
- (BOOL)v4_isEmpty;
- (void)v4_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block;

// v5 syncronizhed实现
- (void)v5_push:(id)anObject;
- (id)v5_pop;
- (BOOL)v5_isEmpty;
- (void)v5_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block;

// v6 mutex实现
- (void)v6_push:(id)anObject;
- (id)v6_pop;
- (BOOL)v6_isEmpty;
- (void)v6_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block;

// v7 OSSpinLock实现
- (void)v7_push:(id)anObject;
- (id)v7_pop;
- (BOOL)v7_isEmpty;
- (void)v7_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block;

@end
