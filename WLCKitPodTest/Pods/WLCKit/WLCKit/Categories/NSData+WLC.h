//
//  NSData+WLC.h
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (WLC)

- (NSString *)hexString;

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;
- (NSString *)base64EncodedString;

///*!
// * @abstract
// * 使用gzip格式进行数据压缩
// *
// * @param level
// * 压缩比，默认为Z_DEFAULT_COMPRESSION
// *
// * @result
// * 压缩后的数据
// */
//- (NSData *)gzippedDataWithCompressionLevel:(float)level;
//
///*!
// * @abstract
// * 使用gzip格式进行数据压缩
// *
// * @discussion
// * 压缩比，默认为Z_DEFAULT_COMPRESSION
// *
// * @result
// * 压缩后的数据
// */
//- (NSData *)gzippedData;
//
///*!
// * @abstract
// * 使用gzip格式进行数据解压缩
// *
// * @result
// * 解压缩后的数据
// */
//- (NSData *)gunzippedData;


@end
