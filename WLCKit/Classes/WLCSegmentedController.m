//
//  WLCSegmentedController.m
//  Training
//
//  Created by lichunwang on 16/12/29.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCSegmentedController.h"
#import "WLCSegmentedControl.h"
#import "UIView+WLC.h"

@interface WLCSegmentedController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate, WLCSegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) WLCSegmentedControl *segmentedControl;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSMutableArray *viewControllers;

@property (assign, nonatomic) NSInteger lastSelectedIndex;

@end

@implementation WLCSegmentedController

+ (instancetype)instance
{
    return [[self alloc] initWithNibName:@"WLCSegmentedController" bundle:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init
{
    self.viewControllers = [NSMutableArray new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    NSArray *viewControllers = [self onConfigViewControllers];
    [self.viewControllers addObjectsFromArray:viewControllers];
    
    [self configPageViewController];
    
    [self configSegmentedControl];
    
    [self updateNavigationItem];
}

- (void)configPageViewController
{
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    [self.pageViewController setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self addChildViewController:self.pageViewController];
    self.pageViewController.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)configSegmentedControl
{
    NSMutableArray *titles = [NSMutableArray new];
    for (UIViewController *vc in self.viewControllers) {
        [titles addObject:vc.title];
    }
    
    self.segmentedControl = [[WLCSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30) segmentTitles:titles];
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    self.segmentedControl.titleColor = [UIColor whiteColor];
    self.segmentedControl.indicatorColor = [UIColor whiteColor];
    self.segmentedControl.dividerWidth = 0;
    self.segmentedControl.delegate = self;
    
    self.navigationItem.titleView = self.segmentedControl;
    
    self.lastSelectedIndex = 0;
}

- (void)updateNavigationItem
{
    UIViewController *selectedViewController = self.viewControllers[self.lastSelectedIndex];
    
    self.navigationItem.leftBarButtonItem = selectedViewController.navigationItem.leftBarButtonItem;
    self.navigationItem.rightBarButtonItem = selectedViewController.navigationItem.rightBarButtonItem;
}

- (NSArray *)onConfigViewControllers
{
    // for subclass
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled
{
    UIScrollView *scrollView = (UIScrollView *)[self.view subviewByTraversingWithCompareBlock:^BOOL(UIView *viewToCheck) {
        if ([viewToCheck isKindOfClass:[UIScrollView class]]) {
            return YES;
        }
        return NO;
    }];
    
    scrollView.scrollEnabled = scrollEnabled;
}

#pragma mark - WLCSegmentedControlDelegate

- (void)segmentedValueChanged:(id)sender
{
    NSInteger selectedIndex = self.segmentedControl.selectedSegmentIndex;
    if (selectedIndex == self.lastSelectedIndex) {
        return;
    }
    
    UIPageViewControllerNavigationDirection direction = selectedIndex > self.lastSelectedIndex ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
    
    [self.pageViewController setViewControllers:@[self.viewControllers[selectedIndex]] direction:direction animated:YES completion:nil];
    
    self.lastSelectedIndex = selectedIndex;
    
    [self updateNavigationItem];
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    
    index--;
    return self.viewControllers[index];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == NSNotFound || index == self.viewControllers.count - 1) {
        return nil;
    }
    
    index++;
    return self.viewControllers[index];
}

#pragma mark - UIPageViewControllerDeleagte

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    self.segmentedControl.selectedSegmentIndex = [self.viewControllers indexOfObject:pageViewController.viewControllers[0]];
    self.lastSelectedIndex = self.segmentedControl.selectedSegmentIndex;
    
    [self updateNavigationItem];
}

@end
