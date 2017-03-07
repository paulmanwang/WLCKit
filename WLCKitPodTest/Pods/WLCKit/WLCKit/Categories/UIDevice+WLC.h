//
//  UIDevice+WLC.h
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (WLC)

+ (double)systemVersion;

@property (readonly, nonatomic) BOOL isPad;

@property (readonly, nonatomic) BOOL isSimulator;

@property (readonly, nonatomic) BOOL isJailbroken;

@property (readonly, nonatomic) BOOL canMakePhoneCalls;

@property (readonly, nonatomic) NSString *machineModel;

@property (readonly, nonatomic) NSString *machineModelName;

@property (readonly, nonatomic) NSDate *systemUptime;

@property (readonly, nonatomic) int64_t diskSpace;
@property (readonly, nonatomic) int64_t diskSpaceFree;
@property (readonly, nonatomic) int64_t diskSpaceUsed;

@property (readonly, nonatomic) int64_t memoryTotal;
@property (readonly, nonatomic) int64_t memoryUsed;
@property (readonly, nonatomic) int64_t memoryFree;
@property (readonly, nonatomic) int64_t memoryActive;
@property (readonly, nonatomic) int64_t memoryInactive;
@property (readonly, nonatomic) int64_t memoryWired;
@property (readonly, nonatomic) int64_t memoryPurgable;

@property (readonly, nonatomic) NSUInteger cpuCount;
@property (readonly, nonatomic) float cpuUsage;
@property (readonly, nonatomic) NSArray<NSNumber *> *cpuUsagePerProcessor;

@end
