//
//  BannerView.h
//  KouDaiSuperMarket
//
//  Created by lichunwang on 16/8/22.
//  Copyright © 2016年 springcome. All rights reserved.
//  轮播图控件

#import <UIKit/UIKit.h>

@class WLCBannerView;

@protocol WLCBannerViewDelegate <NSObject>

- (void)wlcBannerViewDidReleasePull:(WLCBannerView *)bannerView;

@end

@interface WLCBannerView : UIView

@property (weak, nonatomic) id<WLCBannerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;

- (void)setImages:(NSArray *)images;

@end
