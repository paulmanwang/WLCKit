//
//  RootViewController.m
//  WLCKitDemo
//
//  Created by lichunwang on 17/2/17.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "RootViewController.h"
#import "WLCToastView.h"
#import "WLCCommentView.h"
#import "NSArray+WLC.h"
#import "WLCStack.h"
#import "NSTimer+WLC.h"

@interface RootViewController ()

@property (strong, nonatomic) WLCStack *testStack;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self fundationTest];
    [self customViewTest];
    [self lockTest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)fundationTest
{
    NSArray *nameList = @[@"张三", @"李四", @"王五"];
    NSArray *copyNameList = [nameList deepCopy];
    
    NSLog(@"nameList = %@", nameList);
    NSLog(@"copyNameList = %@", copyNameList);
    
    [NSTimer wlc_scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer *timer){
        NSLog(@"定时器测试");
    }];
}

- (void)customViewTest
{
    [WLCToastView toastWithMessage:@"我在测试"];
    
    WLCCommentView *commentView = [WLCCommentView wlcCommentView];
    [self.view addSubview:commentView];
}

- (void)lockTestWithMethodName:(NSString *)methodName
                   pushSel:(SEL)pushSelector
                    popSel:(SEL)popSelector
{
    NSTimeInterval beginTime, endTime;
    NSInteger count = 1000000;
    NSNumber *object = @(100);
    
    beginTime = CACurrentMediaTime();
    for (NSInteger i = 0; i < count; i++) {
        [self.testStack performSelectorOnMainThread:pushSelector withObject:object waitUntilDone:YES];
        [self.testStack performSelectorOnMainThread:popSelector withObject:object waitUntilDone:YES];
    }
    endTime = CACurrentMediaTime();
    NSLog(@"%@: %8.2f ms\n", methodName, (endTime - beginTime) * 1000);
}

- (void)lockTest
{
    [self lockTestWithMethodName:@"dispatch_semaphore" pushSel:@selector(push:) popSel:@selector(pop)];
    [self lockTestWithMethodName:@"nslock" pushSel:@selector(push:) popSel:@selector(pop)];
    [self lockTestWithMethodName:@"dispatch_barrier_async" pushSel:@selector(push:) popSel:@selector(pop)];
    [self lockTestWithMethodName:@"serial dispatch queue" pushSel:@selector(push:) popSel:@selector(pop)];
    [self lockTestWithMethodName:@"@synchronized" pushSel:@selector(push:) popSel:@selector(pop)];
    [self lockTestWithMethodName:@"mutex" pushSel:@selector(push:) popSel:@selector(pop)];
    [self lockTestWithMethodName:@"spinlock" pushSel:@selector(push:) popSel:@selector(pop)];
}

@end
