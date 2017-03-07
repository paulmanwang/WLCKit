//
//  UIButton+WLC.h
//  ShortcutKeyBook
//
//  Created by lichunwang on 16/7/11.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WLC)

@property (assign, nonatomic) NSString *title;

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                     tapBlock:(void(^)(void))tapBlock;

- (void)addAction:(void(^)(void))actionBlock;

@end
