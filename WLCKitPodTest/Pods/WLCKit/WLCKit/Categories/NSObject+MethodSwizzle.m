//
//  NSObject+MethodSwizzle.m
//  MyDemos
//
//  Created by lichunwang on 16/12/8.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "NSObject+MethodSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwizzle)

// 下面这种情况要特别注意 https://segmentfault.com/q/1010000002931540
//当用Method Swizzling替换子类中未重写的父类方法实现时，class_getInstanceMethod会获取到子类没有重写的父类方法的Method，这个Method对应的是父类中的方法，用这个Method调用method_exchangeImplementations实现Method Swizzling之后就会交换父类Method和子类Method的实现。然后在基类对象上调用被交换的方法时，如果该方法调用了自身就会引起unrecognized selector异常。
+ (BOOL)exchangeInstanceMethod:(SEL)originalSelector
         withNewInstanceMethod:(SEL)newSelector
{
//    The method that corresponds to the implementation of the selector specified by aSelector for the class specified by aClass,
//        or NULL if the specified class or its superclasses do not contain an instance method with the specified selector.
    Method originalMethod = class_getInstanceMethod(self, originalSelector); // 这里会检测父类的selector
    if (!originalMethod) {
        return NO;
    }
    
    Method newMethod = class_getInstanceMethod(self, newSelector);
    if (!newMethod) {
        return NO;
    }
    
    // method_exchangeImplementations(originalMethod, newMethod); // 直接替换风险很大啊
    
    // YES if the method was added successfully, otherwise NO (for example, the class already contains a method implementation with that name).
    BOOL success = class_addMethod([self class], originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (success) { // 说明方法不存在
        class_replaceMethod([self class], newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)); // 方法不存在，相当于使用了父类的IMP
    }
    else { // 说明方法已存在
        method_exchangeImplementations(originalMethod, newMethod); // 方法都存在则直接交互
    }
    
    return YES;
}

+ (BOOL)exchangeClassMethod:(SEL)originalSelector
         withNewClassMethod:(SEL)newSelector
{
    Method originalMethod = class_getClassMethod(self, originalSelector);
    if (!originalMethod) {
        return NO;
    }
    
    Method newMethod = class_getClassMethod(self, newSelector);
    if (!newMethod) {
        return NO;
    }
    
    method_exchangeImplementations(originalMethod, newMethod);
    
    return YES;
}

@end
