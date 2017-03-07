//
//  PHAsset+WLC.h
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/PHAsset.h>

@interface PHAsset (WLC)

@property (copy, readonly, nonatomic) NSString *contentType;

@end
