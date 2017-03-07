//
//  NSString+WLC.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/23.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "NSString+WLC.h"

@implementation NSString (WLC)

- (NSString *)stringWithDictionary:(NSDictionary *)dic
{
    if (dic.allKeys.count == 0) {
        return nil;
    }
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    if (error) {
        return nil;
    }
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)toDictionary
{
    if (self.length == 0) {
        return nil;
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *serializeError;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingAllowFragments
                                                           error:&serializeError];
    if (serializeError) {
        NSLog(@"serializeError = %@", serializeError.localizedDescription);
    }
    
    return dict;
}

@end
