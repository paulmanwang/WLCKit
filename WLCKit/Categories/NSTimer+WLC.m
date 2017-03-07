//
//  NSTimer+WLC.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/20.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "NSTimer+WLC.h"

@implementation NSTimer (WLC)

+ (NSTimer *)wlc_addTimerWithTimerInterval:(NSTimeInterval)seconds
                                  repeates:(BOOL)repeats
                                     block:(void(^)(NSTimer *timer))block
{
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(_wlc_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)wlc_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block
{
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(_wlc_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)_wlc_ExecBlock:(NSTimer *)timer
{
    void(^block)(NSTimer *timer) = timer.userInfo;
    if (block) {
        block(timer);
    }
}

@end
