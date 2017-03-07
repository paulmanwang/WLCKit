//
//  WLCFileTypeCheck.m
//  Training
//
//  Created by lichunwang on 17/1/12.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "WLCFileTypeCheck.h"

@implementation WLCFileTypeCheck

+ (BOOL)checkImage:(NSString*)fileSuffix
{
    // TODO 待优化
    // JPEG、PNG、BMP、GIF、JPG、ICO、TIF
    static NSMutableArray *imageSuffixArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageSuffixArray = [[NSMutableArray alloc] init];
        [imageSuffixArray addObject:@"JPEG"];
        [imageSuffixArray addObject:@"PNG"];
        [imageSuffixArray addObject:@"BMP"];
        [imageSuffixArray addObject:@"GIF"];
        [imageSuffixArray addObject:@"JPG"];
        [imageSuffixArray addObject:@"ICO"];
        [imageSuffixArray addObject:@"TIF"];
    });
    
    for(NSString *suffix in imageSuffixArray) {
        // 忽略大小写
        if([fileSuffix caseInsensitiveCompare:suffix]==NSOrderedSame) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)checkVideo:(NSString*)fileSuffix
{
    // TODO 待优化
    // MP4、FLV、3GP、MKV、RMVB、ASF、AVI、MPG、F4V、TS、WMV、M4V、SWF、MOV、DAT
    static NSMutableArray *videoSuffixArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoSuffixArray = [[NSMutableArray alloc] init];
        [videoSuffixArray addObject:@"MP4"];
        [videoSuffixArray addObject:@"3GP"];
        [videoSuffixArray addObject:@"MKV"];
        [videoSuffixArray addObject:@"RMVB"];
        [videoSuffixArray addObject:@"ASF"];
        [videoSuffixArray addObject:@"AVI"];
        [videoSuffixArray addObject:@"MPG"];
        [videoSuffixArray addObject:@"F4V"];
        [videoSuffixArray addObject:@"TS"];
        [videoSuffixArray addObject:@"WMV"];
        [videoSuffixArray addObject:@"M4V"];
        [videoSuffixArray addObject:@"SWF"];
        [videoSuffixArray addObject:@"MOV"];
        [videoSuffixArray addObject:@"DAT"];
        [videoSuffixArray addObject:@"RM"];
    });
    
    for(NSString *suffix in videoSuffixArray) {
        // 忽略大小写
        if([fileSuffix caseInsensitiveCompare:suffix]==NSOrderedSame) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)checkDocument:(NSString*)fileSuffix
{
    // TODO 待优化
    // MP4、FLV、3GP、MKV、RMVB、ASF、AVI、MPG、F4V、TS、WMV、M4V、SWF、MOV、DAT
    static NSMutableArray *documentSuffixArray = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        documentSuffixArray = [[NSMutableArray alloc] init];
        [documentSuffixArray addObject:@"txt"];
        [documentSuffixArray addObject:@"doc"];
        [documentSuffixArray addObject:@"docx"];
        [documentSuffixArray addObject:@"xls"];
        [documentSuffixArray addObject:@"xlsx"];
        [documentSuffixArray addObject:@"ppt"];
        [documentSuffixArray addObject:@"pptx"];
        [documentSuffixArray addObject:@"pdf"];
    });
    
    for(NSString *suffix in documentSuffixArray) {
        // 忽略大小写
        if([fileSuffix caseInsensitiveCompare:suffix]==NSOrderedSame) {
            return YES;
        }
    }
    
    return NO;
}

@end
