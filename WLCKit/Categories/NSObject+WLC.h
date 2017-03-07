//
//  NSObject+WLC.h
//  MyDemos
//
//  Created by lichunwang on 16/11/18.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (WLC)

- (void)performBlockLater:(void(^)(void))block;

- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)seconds;

- (void)syncBlockInMainQueue:(void(^)(void))block;

- (void)asyncBlockInMainQueue:(void(^)(void))block;

- (void)setAssociateObject:(id)value forKey:(void *)key;

- (void)setAssociateWeakObject:(id)value forKey:(void *)key;

- (id)getAssociatedObjectForKey:(void *)key;

- (void)removeAssociatedObjectForKey:(void *)key;

- (void)removeAllAssociatedObjects;

@end
