//
//  RootViewController.m
//  WLCKitPodTest
//
//  Created by lichunwang on 17/2/16.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "RootViewController.h"
#import <WLCKit/WLCEmptyView.h>

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [WLCEmptyView showOnView:self.view withText:@"空白视图" icon:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
