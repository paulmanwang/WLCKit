//
//  JSContext+WLC.h
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/23.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@interface JSContext (WLC)

/**
 获取webview中的jscontext

 @param webView 浏览器控件

 @return JS上下文
 */
+ (JSContext *)contextWithWebView:(UIWebView *)webView;


/**
 向JSContext中注册新对象

 @param obj     待注册对象
 @param objName 对象名称
 */
- (void)registerObj:(id)obj withName:(NSString *)objName;


/**
 调用jscontext中不带参数的方法，该方法中不带参数

 @param selector 调用的方法
 */
- (void)performSelector:(SEL)selector;


/**
 调用jscontext中带参数的方法

 @param selector  调用的方法
 @param arguments 方法需要传递的参数，将参数按原有顺序组合成数组
 */
- (void)performSelector:(SEL)selector withArguments:(NSArray *)arguments;

@end
