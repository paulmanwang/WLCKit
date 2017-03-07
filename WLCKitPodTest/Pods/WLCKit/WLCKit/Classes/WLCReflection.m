//
//  WLCReflection.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/3/1.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "WLCReflection.h"
#import <objc/runtime.h>

@implementation WLCReflection

+ (NSString *)propertyTypeOfClass:(Class)classType propertyName:(NSString *)propertyName
{
    objc_property_t property = class_getProperty(classType, propertyName.UTF8String);
    NSString *attributes = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
    
    NSString *type = nil;
    if ([attributes hasPrefix:@"T@"]) {
        NSArray *substrings = [attributes componentsSeparatedByString:@"\""];
        if ([substrings count] >= 2) {
            type = [substrings objectAtIndex:1];
        } else {
            type = @"id";
        }
    } else if ([attributes hasPrefix:@"T{"]) {
        type = @"struct";
    } else {
        if ([attributes hasPrefix:@"Ti"]) {
            type = @"int";
        } else if ([attributes hasPrefix:@"TI"]) {
            type = @"unsigned";
        } else if ([attributes hasPrefix:@"Ts"]) {
            type = @"short";
        } else if ([attributes hasPrefix:@"Tl"]) {
            type = @"long";
        } else if ([attributes hasPrefix:@"TL"]) {
            type = @"unsigned long";
        } else if ([attributes hasPrefix:@"Tq"]) {
            type = @"long long";
        } else if ([attributes hasPrefix:@"TQ"]) {
            type = @"unsigned long long";
        } else if ([attributes hasPrefix:@"TB"]) {
            type = @"bool";
        } else if ([attributes hasPrefix:@"Tf"]) {
            type = @"float";
        } else if ([attributes hasPrefix:@"Td"]) {
            type = @"double";
        } else if ([attributes hasPrefix:@"Tc"]) {
            type = @"char";
        } else if ([attributes hasPrefix:@"T^i"]) {
            type = @"int *";
        } else if ([attributes hasPrefix:@"T^I"]) {
            type = @"unsigned *";
        } else if ([attributes hasPrefix:@"T^s"]) {
            type = @"short *";
        } else if ([attributes hasPrefix:@"T^l"]) {
            type = @"long *";
        } else if ([attributes hasPrefix:@"T^q"]) {
            type = @"long long *";
        } else if ([attributes hasPrefix:@"T^Q"]) {
            type = @"unsigned long long *";
        } else if ([attributes hasPrefix:@"T^B"]) {
            type = @"bool *";
        } else if ([attributes hasPrefix:@"T^f"]) {
            type = @"float *";
        } else if ([attributes hasPrefix:@"T^d"]) {
            type = @"double *";
        } else if ([attributes hasPrefix:@"T*"]) {
            type = @"char *";
        } else {
            NSAssert(0, @"Unkonwn type");
        }
    }
    
    return type;
}

+ (NSArray *)getAllPropertyNamesOfClass:(Class)classType
{
    NSArray *cachedNameList = objc_getAssociatedObject(classType, @"kPropertyNames");
    if (cachedNameList) {
        return cachedNameList;
    }
    
    NSMutableArray *propertyNameList = [NSMutableArray new];
    unsigned int propertyCount;
    objc_property_t *propertyList = class_copyPropertyList(classType, &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        [propertyNameList addObject:propertyName];
    }
    
    objc_setAssociatedObject(self, @"kPropertyNames", propertyNameList, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    free(propertyList);
    
    return propertyNameList;
}

@end
