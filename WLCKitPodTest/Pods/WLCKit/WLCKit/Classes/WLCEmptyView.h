//
//  EmptyView.h
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/7/16.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLCEmptyView : UIView

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

+ (instancetype)showOnView:(UIView *)view withText:(NSString *)text icon:(NSString *)icon;

@end

@interface UIViewController (EmptyView)

- (void)showEmptyViewWithText:(NSString *)text icon:(NSString *)icon;

- (void)dismissEmptyView;

@end
