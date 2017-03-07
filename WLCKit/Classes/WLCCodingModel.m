//
//  WLCCodingModel.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/3/1.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "WLCCodingModel.h"
#import "WLCReflection.h"

@implementation WLCCodingModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        NSArray *propertyNameList = [WLCReflection getAllPropertyNamesOfClass:[self class]];
        for (NSString *propertyName in propertyNameList) {
            id value = [aDecoder decodeObjectForKey:propertyName];
            [self setValue:value forKey:propertyName];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSArray *propertyNameList = [WLCReflection getAllPropertyNamesOfClass:[self class]];
    for (NSString *propertyName in propertyNameList) {
        id value = [self valueForKey:propertyName]; // 获取值
        [aCoder encodeObject:value forKey:propertyName];
    }
}


@end
