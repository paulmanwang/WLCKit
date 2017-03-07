//
//  WLCStack.m
//  MyDemos
//
//  Created by lichunwang on 16/12/9.
//  Copyright © 2016年 springcome. All rights reserved.
//

// 说明：
// semaphore只包含如下三个API
// dispatch_semaphore_create
// dispatch_semaphore_wait
// dispatch_semaphore_signal

// 性能对比：http://www.jianshu.com/p/4edf98a61483
// 来自YYKit的描述：semphore的方式 higher than using @synchronized, NSLock, or pthread_mutex_t.


#import "WLCStack.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>

@interface WLCStack ()

@property (strong, nonatomic) NSMutableArray *stack;
@property (strong, nonatomic) dispatch_semaphore_t semaphore;
@property (strong, nonatomic) NSLock *lock; // 这里可以用递归锁NSRecursiveLock替代，性能未知。NSConditionLock、NSCondition
@property (strong, nonatomic) dispatch_queue_t concurentQueue;
@property (strong, nonatomic) dispatch_queue_t serialQueue;
@property (assign, nonatomic) pthread_mutex_t mutex;
@property (assign, nonatomic) OSSpinLock spinLock; // 性能很高，但是已经不安全了http://blog.ibireme.com/2016/01/16/spinlock_is_unsafe_in_ios/

@end

@implementation WLCStack

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.stack = [NSMutableArray new];
        self.semaphore = dispatch_semaphore_create(1);
        self.lock = [NSLock new];
        self.concurentQueue = dispatch_queue_create("com.springcom.www.concurent.queue", DISPATCH_QUEUE_CONCURRENT);
        self.serialQueue = dispatch_queue_create("com.springcom.www.serial.queue", DISPATCH_QUEUE_SERIAL);
        pthread_mutex_init(&_mutex, NULL);
        self.spinLock = OS_SPINLOCK_INIT;
    }
    
    return self;
}

#pragma mark - V1 semaphore implementation

- (BOOL)isEmpty
{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    BOOL empty = self.stack.count == 0;
    dispatch_semaphore_signal(self.semaphore);
    
    return empty;
}

- (void)push:(id)anObject
{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.stack addObject:anObject];
    dispatch_semaphore_signal(self.semaphore);
}

- (id)pop
{
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    NSAssert(self.stack.count > 0, @"stack is empty");
    id object = [self.stack lastObject];
    [self.stack removeObject:object];
    dispatch_semaphore_signal(self.semaphore);
    
    return object;
}

- (void)enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
    NSAssert(block, @"block is nil");
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    [self.stack enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            block(obj, idx, stop);
        }
    }];
    dispatch_semaphore_signal(self.semaphore);
}

#pragma mark - V2 lock implementation

- (void)v2_push:(id)anObject
{
    [self.lock lock];
    [self.stack addObject:anObject];
    [self.lock unlock];
}

- (id)v2_pop
{
    [self.lock lock];
    id object = [self.stack lastObject];
    [self.stack removeObject:object];
    [self.lock unlock];
    
    return object;
}

- (BOOL)v2_isEmpty
{
    [self.lock lock];
    BOOL empty = self.stack.count == 0;
    [self.lock unlock];
    
    return empty;
}

- (void)v2_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
    [self.lock lock];
    [self.stack enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            block(obj, idx, stop);
        }
    }];
    [self.lock unlock];
}

#pragma mark - V3 dispatch_barrier_async+concurent dispatch queue实现

- (void)v3_push:(id)anObject
{
    dispatch_barrier_async(self.concurentQueue, ^{
        [self.stack addObject:anObject];
    });
}

- (id)v3_pop
{
    __block id object;
    dispatch_barrier_sync(self.concurentQueue, ^{
        object = [self.stack lastObject];
        [self.stack removeObject:object];
    });
    
    return object;
}

- (BOOL)v3_isEmpty
{
    __block BOOL emtpy;
    dispatch_sync(self.concurentQueue, ^{
        emtpy = self.stack.count == 0;
    });
    
    return emtpy;
}

- (void)v3_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
    dispatch_sync(self.concurentQueue, ^{
        [self.stack enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (block) {
                block(obj, idx, stop);
            }
        }];
    });
}

#pragma mark - V4 serial dispatch queue实现

- (void)v4_push:(id)anObject
{
    dispatch_sync(self.serialQueue, ^{
        [self.stack addObject:anObject];
    });
}

- (id)v4_pop
{
    __block id object;
    dispatch_sync(self.serialQueue, ^{
        id object = [self.stack lastObject];
        [self.stack removeObject:object];
    });
    
    return object;
}

- (BOOL)v4_isEmpty
{
    __block BOOL empty;
    dispatch_sync(self.serialQueue, ^{
        empty = self.stack.count == 0;
    });
    
    return empty;
}

- (void)v4_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
    dispatch_sync(self.serialQueue, ^{
        [self.stack enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (block) {
                block(obj, idx, stop);
            }
        }];
    });
}

#pragma mark - V5 synchronized指令实现

- (void)v5_push:(id)anObject
{
    @synchronized (self) {
        [self.stack addObject:anObject];
    }
}

- (id)v5_pop
{
    @synchronized (self) {
        id object = [self.stack lastObject];
        [self.stack removeObject:object];
        return object;
    }
}

- (BOOL)v5_isEmpty
{
    @synchronized (self) {
        return self.stack == 0;
    }
}

- (void)v5_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
    @synchronized (self) {
        [self.stack enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (block) {
                block(obj, idx, stop);
            }
        }];
    }
}

#pragma mark - mutex实现

- (void)v6_push:(id)anObject
{
    pthread_mutex_lock(&_mutex);
    [self.stack addObject:anObject];
    pthread_mutex_unlock(&_mutex);
    
}

- (id)v6_pop
{
    pthread_mutex_lock(&_mutex);
    id object = [self.stack lastObject];
    [self.stack removeObject:object];
    pthread_mutex_unlock(&_mutex);
    
    return object;
}

- (BOOL)v6_isEmpty
{
    pthread_mutex_lock(&_mutex);
    BOOL empty = self.stack.count == 0;
    pthread_mutex_unlock(&_mutex);
    
    return empty;
}

- (void)v6_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
    pthread_mutex_lock(&_mutex);
    [self.stack enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            block(obj, idx, stop);
        }
    }];
    pthread_mutex_unlock(&_mutex);
}

#pragma mark - v7 OSSpinLock

- (void)v7_push:(id)anObject
{
    OSSpinLockLock(&_spinLock);
    [self.stack addObject:anObject];
    OSSpinLockUnlock(&_spinLock);
}

- (id)v7_pop
{
    OSSpinLockLock(&_spinLock);
    id object = [self.stack lastObject];
    [self.stack removeObject:object];
    OSSpinLockUnlock(&_spinLock);
    
    return object;
}

- (BOOL)v7_isEmpty
{
    OSSpinLockLock(&_spinLock);
    BOOL empty = self.stack.count == 0;
    OSSpinLockUnlock(&_spinLock);
    
    return empty;
}

- (void)v7_enumerateObjectsUsingBlock:(void(^)(id object, NSUInteger index, BOOL *stop))block
{
    OSSpinLockLock(&_spinLock);
    [self.stack enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (block) {
            block(obj, idx, stop);
        }
    }];
    OSSpinLockUnlock(&_spinLock);
}

@end
