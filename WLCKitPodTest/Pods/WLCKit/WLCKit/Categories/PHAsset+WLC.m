//
//  PHAsset+WLC.m
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "PHAsset+WLC.h"
#import <Photos/PHImageManager.h>
#import <Photos/PHAssetResource.h>

@implementation PHAsset (WLC)

- (NSString *)contentType
{
    NSArray *resources = [PHAssetResource assetResourcesForAsset:self];
    NSString *orgFilename = ((PHAssetResource*)resources[0]).originalFilename;
    
    NSString *fileType = @"";
    NSString *suffix  = [[orgFilename pathExtension] uppercaseString];
    if ([suffix isEqualToString:@"PNG"]) {
        fileType = @"image/png";
    }
    else if ([suffix isEqualToString:@"JPEG"]){
        fileType = @"image/jpeg";
    }
    else {
        fileType = @"video/quicktime";
    }
    
    return fileType;
}

@end
