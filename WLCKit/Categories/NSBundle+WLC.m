//
//  NSBundle+WLC.m
//  Training
//
//  Created by lichunwang on 17/2/7.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "NSBundle+WLC.h"

@implementation NSBundle (WLC)

+ (NSString *)appName
{
//    A dictionary, constructed from the bundle's Info.plist file, that contains information about the receiver.
//    If the bundle does not contain an Info.plist file, this dictionary contains only private keys that are used internally by the NSBundle class. The NSBundle class may add extra keys to this dictionary for its own use. Common keys for accessing the values of the dictionary are CFBundleIdentifier, NSMainNibFile, and NSPrincipalClass.
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary[@"CFBundleDisplayName"];
}

+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary[@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary[@"CFBundleVersion"];
}

+ (NSBundle *)wlcKitBundle
{
    // 首先判断是否在mainBundle下
    NSURL *resourceUrl = [[NSBundle mainBundle] URLForResource:@"WLCKitBundle" withExtension:@"bundle"];
    if (resourceUrl == nil) {
        // 使用CocoaPods导入时，bundle位于Frameworks下
        resourceUrl = [[NSBundle mainBundle] URLForResource:@"Frameworks/WLCKit.framework/WLCKitBundle" withExtension:@"bundle"];
    }
    
    if (resourceUrl) {
        NSLog(@"resourceUrl is %@", resourceUrl.absoluteString);
        return [NSBundle bundleWithURL:resourceUrl];
    }
    
    NSLog(@"resourceUrl == nil");
    return nil;
}

@end
