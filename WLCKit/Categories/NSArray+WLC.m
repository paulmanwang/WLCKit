//
//  NSArray+WLC.m
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "NSArray+WLC.h"
#import "WLCThreadSafeArray.h"

@implementation NSArray (WLC)

- (id)deepCopy
{
//    If YES, each object in array receives a copyWithZone: message to create a copy of the object—objects must conform to the NSCopying protocol. In a managed memory environment, this is instead of the retain message the object would otherwise receive. The object copy is then added to the returned array.
//    If NO, then in a managed memory environment each object in array simply receives a retain message when it is added to the returned array.
    return [[NSArray alloc] initWithArray:self copyItems:YES];
}

- (id)mutableDeepCopy
{
    return [[NSMutableArray alloc] initWithArray:self copyItems:YES];
}

- (id)trueDeepCopy
{
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];
    } @catch (NSException *exception) {
        NSLog(@"trueDeepCopy exception = %@", exception);
    }
    
    return obj;
}

- (id)trueMutableDeepCopy
{
    id obj = nil;
    @try {
        obj = [[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]] mutableCopy];
    } @catch (NSException *exception) {
        NSLog(@"trueMutableDeepCopy exception = %@", exception);
    }
    
    return obj;
}

- (NSUInteger)searchValue:(id)value
                    begin:(NSUInteger)begin
                      end:(NSUInteger)end
{
    if (begin == end) {
        NSNumber *compare = self[begin];
        if ([compare compare:value] == NSOrderedSame) {
            return begin;
        }
        
        return -1;
    }
    
    NSUInteger count = end - begin;
    NSUInteger index = count / 2;
    NSNumber *compare = self[index];
    
    if ([compare compare:value] == NSOrderedSame) {
        return index;
    }
    else if ([compare compare:value] == NSOrderedDescending) {
        return [self searchValue:value begin:begin end:index-1];
    }
    else {
        return [self searchValue:value begin:index+1 end:end];
    }
}

- (NSInteger)binarySearchValue:(id)value
{
    return [self searchValue:value begin:0 end:self.count-1];
}

@end
