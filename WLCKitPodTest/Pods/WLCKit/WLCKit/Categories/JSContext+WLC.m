//
//  JSContext+WLC.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/23.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "JSContext+WLC.h"

@implementation JSContext (WLC)

+ (JSContext *)contextWithWebView:(UIWebView *)webView
{
    return [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
}

- (void)registerObj:(id)obj withName:(NSString *)objName
{
    if (obj || objName.length > 0) {
        [self setObject:obj forKeyedSubscript:objName];
    }
}

- (void)performSelector:(SEL)selector
{
    NSString *selectorString = NSStringFromSelector(selector);
    if (selectorString.length > 0) {
        [self evaluateScript:selectorString];
    }
}

- (void)performSelector:(SEL)selector withArguments:(NSArray *)arguments
{
    NSString *selectorString = NSStringFromSelector(selector);
    if (selectorString.length > 0) {
        JSValue *function = [self objectForKeyedSubscript:selectorString];
        if (function) {
            [function callWithArguments:arguments];
        }
    }
}

@end
