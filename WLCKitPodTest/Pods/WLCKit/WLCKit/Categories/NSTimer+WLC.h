//
//  NSTimer+WLC.h
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/20.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WLC)

+ (NSTimer *)wlc_addTimerWithTimerInterval:(NSTimeInterval)seconds
                                  repeates:(BOOL)repeats
                                     block:(void(^)(NSTimer *timer))block;

+ (NSTimer *)wlc_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds
                                        repeats:(BOOL)repeats
                                          block:(void(^)(NSTimer *timer))block;

@end
