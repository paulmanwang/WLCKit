//
//  WLCSandBox.h
//  Training
//
//  Created by lichunwang on 17/1/12.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline NSString *AppPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    
    return paths[0];
}

static inline NSString *DocPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return paths[0];
}

static inline NSString *LibPrefPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [paths[0] stringByAppendingString:@"/Preference"];
}

static inline NSString *LibCachePath()
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [path[0] stringByAppendingString:@"/Caches"];
}

static inline NSString *TmpPath()
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    return [paths[0] stringByAppendingString:@"/tmp"];
}



