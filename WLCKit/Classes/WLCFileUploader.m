//
//  WLCFileUploader.m
//  Training
//
//  Created by lichunwang on 17/2/6.
//  Copyright © 2017年 springcome. All rights reserved.
//

#import "WLCFileUploader.h"
// #import <AFNetworking/AFNetworking.h>

@implementation WLCFileUploader

+ (void)uploadFileWithPath:(NSString *)path
                      name:(NSString *)name
                  fileName:(NSString *)fileName
                  fileData:(NSData *)fileData
               contentType:(NSString *)contentType
                   timeoutInterval:(NSTimeInterval)timeoutInterval
                  progress:(void(^)(NSProgress *uploadProgress))progress
                completion:(void(^)(NSError *error, NSDictionary *responseObject))completion
{
//    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
//    sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
//    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [sessionManager POST:path parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:contentType];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        if (progress) {
//            progress(uploadProgress);
//        }
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (completion) {
//            completion(nil, responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (completion) {
//            completion(error, nil);
//        }
//    }];
}

@end
