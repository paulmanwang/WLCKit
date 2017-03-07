//
//  NSArray+WLC.h
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (WLC)

#pragma mark - Copy

- (id)deepCopy;

- (id)mutableDeepCopy;

- (id)trueDeepCopy;

- (id)trueMutableDeepCopy;

#pragma mark - Search


/**
 二分查找

 @param value 待查找的对象

 @return 对象所在的下标
 */
- (NSInteger)binarySearchValue:(id)value;

@end
