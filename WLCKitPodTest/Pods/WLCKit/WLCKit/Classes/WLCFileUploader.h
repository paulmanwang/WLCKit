//
//  WLCFileUploader.h
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLCFileUploader : NSObject

/**
 上传文件

 @param path            文件上传的目的地址，该地址为一个完整的url
 @param name            multipart协议中的name表示
 @param fileName        上传至服务器的文件名称
 @param fileData        文件内容
 @param contentType     文件类型
 @param timeoutInterval 上传的超时时间
 @param progress        上传进度block
 @param completion      上传完成block
 */
+ (void)uploadFileWithPath:(NSString *)path
                      name:(NSString *)name
                  fileName:(NSString *)fileName
                  fileData:(NSData *)fileData
               contentType:(NSString *)contentType
           timeoutInterval:(NSTimeInterval)timeoutInterval
                  progress:(void(^)(NSProgress *uploadProgress))progress
                completion:(void(^)(NSError *error, NSDictionary *responseObject))completion;

@end
