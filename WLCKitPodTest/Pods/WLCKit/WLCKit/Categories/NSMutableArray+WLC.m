//
//  NSMutableArray+WLC.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/20.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "NSMutableArray+WLC.h"

@implementation NSMutableArray (WLC)

- (void)bubbleSort
{
    NSUInteger count = self.count;
    
    for (NSUInteger i = 0; i < count; i++) {
        for (NSUInteger j = count - i - 1; j < count; j++) {
            NSNumber *value1 = [self objectAtIndex:i];
            NSNumber *value2 = [self objectAtIndex:j];
            if ([value1 compare:value2] == NSOrderedAscending) {
                [self exchangeObjectAtIndex:i withObjectAtIndex:j];
            }
        }
    }
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"bubble object = %@", obj);
    }];
}

- (void)quickSortWithBegin:(NSInteger)begin end:(NSInteger)end
{
    NSNumber *compare = [self objectAtIndex:begin];
    NSInteger left = begin;
    NSInteger right = end;
    
    while (right > left) {
        while (right > left) {
            NSNumber *value = [self objectAtIndex:right];
            if ([value compare:compare] == NSOrderedDescending || [value compare:compare] == NSOrderedSame) {
                right--;
            }
            else {
                break;
            }
        }
        [self exchangeObjectAtIndex:left withObjectAtIndex:right];
        
        while (right > left) {
            NSNumber *value = [self objectAtIndex:left];
            if ([value compare:compare] == NSOrderedAscending || [value compare:compare] == NSOrderedSame) {
                left++;
            }
            else {
                break;
            }
        }
        [self exchangeObjectAtIndex:left withObjectAtIndex:right];
    }
    
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"quicksort object = %@", obj);
    }];
    
    NSLog(@"left = %li", left);
    if (begin < (left - 1)) { // 卧槽，NSUInteger，当left为0时，然后-1之后，由于没有负数，变成了18446744073709551615（2的64次方-1），改为NSInteger
        [self quickSortWithBegin:begin end:left-1];
    }
    
    if ((left + 1) < end) {
        [self quickSortWithBegin:left+1 end:end];
    }
}

- (void)quickSort
{
    [self quickSortWithBegin:0 end:self.count - 1];
}

- (void)heapSort
{
    
}


@end
