//
//  BannerView.m
//  KouDaiSuperMarket
//
//  Created by lichunwang on 16/8/22.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "WLCBannerView.h"
#import "UIView+WLC.h"
#import "WLCAnimation.h"

@interface WLCBannerPullView : UIView

@property (strong, nonatomic) UIImageView *arrowImageView;
@property (strong, nonatomic) UILabel *textLabel;
@property (copy, nonatomic) NSString *text;
@property (strong, nonatomic) WLCAnimation *wlcAnimation;

- (void)setText:(NSString *)text;
- (NSString *)text;

@end

@implementation WLCBannerPullView

- (WLCAnimation *)wlcAnimation
{
    if (!_wlcAnimation) {
        _wlcAnimation = [WLCAnimation new];
    }
    
    return _wlcAnimation;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrowImageView = [UIImageView new];
        self.arrowImageView.size = CGSizeMake(16, 16);
        self.arrowImageView.center = CGPointMake(16, self.height / 2);
        self.arrowImageView.image = [UIImage imageNamed:@"navi_back_btn"];
        self.arrowImageView.backgroundColor = [UIColor blackColor];
        self.arrowImageView.layer.cornerRadius = 8;
        self.arrowImageView.clipsToBounds = YES;
        [self addSubview:self.arrowImageView];
        
        self.textLabel = [UILabel new];
        self.textLabel.size = CGSizeMake(20, self.height);
        self.textLabel.center = CGPointMake(40, self.height / 2);
        self.textLabel.text = @"滑动查看图文详情";
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.numberOfLines = 0;
        [self addSubview:self.textLabel];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.arrowImageView.center = CGPointMake(15, self.height / 2);
    self.textLabel.center = CGPointMake(35, self.height / 2);
}

- (void)setText:(NSString *)text
{
    self.textLabel.text = text;
}

- (NSString *)text
{
    return self.textLabel.text;
}

@end

@interface WLCBannerView ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *imageViewList;
@property (copy, nonatomic) NSArray *imageList;

@property (strong, nonatomic) WLCBannerPullView *pullView;

@end

@implementation WLCBannerView

- (void)awakeFromNib
{
    // 实验证明，当WLCBannerView嵌入在xib里面时，这个函数会被调用，同时注意下面的initWithFrame并不会调用。
    [super awakeFromNib];
    NSLog(@"awakeFromNib");
    [self addSubViews];
    [self updateSubviewsFrame];
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews");
    [super layoutSubviews];
    [self updateSubviewsFrame];
}

#pragma mark - Public

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;
{
    self = [super initWithFrame:frame];
    NSLog(@"height = %f", frame.size.height);
    if (self) {
        self.imageList = images;
        [self addSubViews];
        [self updateSubviewsFrame];
    }
    
    return self;
}

// 这个方法没啥用
- (instancetype)initWithFrame:(CGRect)frame
{
    NSLog(@"initWithFrame进来了");
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self updateSubviewsFrame];
    }
    
    return self;
}

- (void)setImages:(NSArray *)images
{
    self.imageList = images;
    [self addImageViews];
    [self updateSubviewsFrame];
}

#pragma mark - SubViews

- (void)addScrollerView
{
    // add scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
}

- (void)addImageViews
{
    NSInteger imagesCount = self.imageList.count;
    if (imagesCount == 0) {
        return;
    }
    
    // clear old imageviews
    for (UIImageView *imageView in self.imageViewList) {
        [imageView removeFromSuperview];
    }
    [self.imageViewList removeAllObjects];
    
    for (NSInteger index = 0; index < imagesCount; index++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.image = self.imageList[index];
        [self.scrollView addSubview:imageView];
        [self.imageViewList addObject:imageView];
    }
    
    // clear old pageControl
    [self.pageControl removeFromSuperview];
    self.pageControl = nil;
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    pageControl.numberOfPages = imagesCount;
    pageControl.currentPage = 0;
    pageControl.backgroundColor = [UIColor clearColor];
    self.pageControl = pageControl;
    [self addSubview:pageControl];
}

- (void)addPullView
{
    // clear old pullview
    [self.pullView removeFromSuperview];
    self.pullView = nil;
    self.pullView = [[WLCBannerPullView alloc] initWithFrame:CGRectMake(0, 0, 50, self.height)];
    [self.scrollView addSubview:self.pullView];
}

- (void)addSubViews
{
    [self addScrollerView];
    [self addImageViews];
    [self addPullView];
}

- (void)updateSubviewsFrame
{
    NSInteger imagesCount = self.imageViewList.count;
    CGFloat width = self.width;
    CGFloat height = self.height;

    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(width * imagesCount, height);
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * width, 0);
    
    for (NSInteger index = 0; index < imagesCount; index++) {
        UIImageView *imageView = self.imageViewList[index];
        imageView.size = CGSizeMake(width, height);
        imageView.position = CGPointMake(index * width, 0);
    }
    
    self.pullView.frame = CGRectMake(width * imagesCount, 0, 50, self.height);
    
    CGFloat pointWidth = 15;
    self.pageControl.size = CGSizeMake(pointWidth * imagesCount, 20);
    self.pageControl.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height - 30);
}

- (NSMutableArray *)imageViewList
{
    if (!_imageViewList) {
        _imageViewList = [NSMutableArray new];
    }
    
    return _imageViewList;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat xoffset = self.scrollView.contentOffset.x;
    self.pageControl.currentPage = xoffset/self.width;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat xoffset = self.scrollView.contentOffset.x;
    if (xoffset > (self.imageList.count - 1) * self.width + 60) {
        if ([self.pullView.text isEqualToString:@"滑动查看图文详情"]) {
            [self.pullView.wlcAnimation addRotationAnimationForView:self.pullView.arrowImageView angle:M_PI duration:0.5];
        }
        self.pullView.text = @"释放查看图文详情";
    }
    else {
        if ([self.pullView.text isEqualToString:@"释放查看图文详情"]) {
            // dp animation
            [self.pullView.wlcAnimation addRotationAnimationForView:self.pullView.arrowImageView angle:0 duration:0.5];
        }
        self.pullView.textLabel.text = @"滑动查看图文详情";
    }
}

 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
    if ([self.pullView.text isEqualToString:@"释放查看图文详情"]) {
        [self.pullView.wlcAnimation addRotationAnimationForView:self.pullView.arrowImageView angle:0 duration:0.5];
        if ([self.delegate respondsToSelector:@selector(wlcBannerViewDidReleasePull:)]) {
            [self.delegate wlcBannerViewDidReleasePull:self];
        }
    }
}

@end
