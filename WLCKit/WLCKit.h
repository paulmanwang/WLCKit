//
//  WLCKit.h
//  WLCKit
//
//  Created by lichunwang on 17/2/16.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - Categories

#import "UIButton+WLC.h"
#import "UIColor+WLC.h"
#import "UIView+WLC.h"
#import "NSDate+WLC.h"
#import "UIImage+WLC.h"
#import "UIViewController+WLC.h"
#import "UIImageView+WLC.h"
#import "UILabel+WLC.h"
#import "PHAsset+WLC.h"
#import "UIScreen+WLC.h"
#import "NSBundle+WLC.h"

#pragma mark - Classes
#import "WLCToastView.h"
#import "WLCPickerView.h"
#import "WLCOnePixelView.h"
#import "WLCSegmentedControl.h"
#import "WLCSegmentedController.h"
#import "WLCEmptyView.h"
#import "WLCFileTypeCheck.h"
#import "WLCFileUploader.h"

#define WLC_DECLARA_SHARED_INSTANCE \
+ (instancetype)sharedInstance;

#define WLC_IMPLEMENTATE_SHARED_INSTANCE(ObjClass) \
+ (instancetype)sharedInstance { \
static ObjClass *obj = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
obj = [[ObjClass alloc] init]; \
}); \
return obj; \
}

#define WLC_OBJECT_INIT \
- (instancetype)init \
{ \
self = [super init]; \
if (self) \
{ \
[self _init]; \
} \
\
return self; \
}

#define WLC_VIEW_CONTROLLER_INIT \
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil \
{ \
self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; \
if (self) { \
[self _init]; \
} \
return self; \
}

#define UIViewAutoresizingFlexibleSize  (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight)
#define UIViewAutoresizingFlexibleMargin (UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin)


//! Project version number for WLCKit.
FOUNDATION_EXPORT double WLCKitVersionNumber;

//! Project version string for WLCKit.
FOUNDATION_EXPORT const unsigned char WLCKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <WLCKit/PublicHeader.h>


