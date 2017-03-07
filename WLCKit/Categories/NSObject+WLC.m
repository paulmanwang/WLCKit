//
//  NSObject+WLC.m
//  MyDemos
//
//  Created by lichunwang on 16/11/18.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "NSObject+WLC.h"
#import <objc/runtime.h>

@implementation NSObject (WLC)

- (void)fireBlock:(void(^)(void))block
{
    if (block) {
        block();
    }
}

- (void)performBlockLater:(void(^)(void))block
{
    block = [block copy];
    
    [self performSelector:@selector(fireBlock:) withObject:block afterDelay:0];
}

- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)seconds
{
    block = [block copy];
    
    [self performSelector:@selector(fireBlock:) withObject:block afterDelay:seconds];
    
    // 方法二，dispatch_get_current_queue方法已废弃
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_current_queue(), ^{
//        block();
//    });
}

- (void)syncBlockInMainQueue:(void(^)(void))block
{
    block = [block copy];
    
    [self performSelectorOnMainThread:@selector(fireBlock:) withObject:block waitUntilDone:YES];

    // 方法二
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        block();
//    });
}

- (void)asyncBlockInMainQueue:(void(^)(void))block
{
    block = [block copy];
    
    [self performSelectorOnMainThread:@selector(fireBlock:) withObject:block waitUntilDone:NO];
    
    // 方法二
//    dispatch_async(dispatch_get_main_queue(), ^{
//        block();
//    });
}

- (void)setAssociateObject:(id)value forKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setAssociateWeakObject:(id)value forKey:(void *)key
{
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id)getAssociatedObjectForKey:(void *)key
{
    return objc_getAssociatedObject(self, key);
}

- (void)removeAllAssociatedObjects
{
    objc_removeAssociatedObjects(self);
}

- (void)removeAssociatedObjectForKey:(void *)key
{
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
