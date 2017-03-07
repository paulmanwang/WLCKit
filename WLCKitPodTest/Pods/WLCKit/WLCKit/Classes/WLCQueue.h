//
//  WLCQueue.h
//  MyDemos
//
//  Created by lichunwang on 16/12/11.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCQueue : NSObject

//back()	返回最后一个元素
//
//empty()	如果队列空则返回真
//
//front()	返回第一个元素
//
//pop()	删除第一个元素
//
//push()	在末尾加入一个元素
//
//size()	返回队列中元素的个数

- (void)push:(id)anObject;
- (id)pop;

- (id)front;
- (id)back;

- (NSUInteger)size;
- (BOOL)empty;

@end
