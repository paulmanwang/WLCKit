//
//  UIImage+WLC.m
//  Training
//
//  Created by lichunwang on 16/12/28.
//  Copyright © 2016年 springcome. All rights reserved.
//

#import "UIImage+WLC.h"

@implementation UIImage (WLC)

- (BOOL)hasAlphaChannel
{
    if (self.CGImage == NULL) {
        return NO;
    }
    
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage) & kCGBitmapAlphaInfoMask;
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (color == nil || size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    The scale factor to apply to the bitmap. If you specify a value of 0.0, the scale factor is set to the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
//    This function is equivalent to calling the UIGraphicsBeginImageContextWithOptions function with the opaque parameter set to NO and a scale factor of 1.0.
//    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByResizeToSize:(CGSize)size
{
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)decodeImage:(UIImage *)image
{
    if (image == nil) {
        return nil;
    }
    
    @autoreleasepool {
        if (image.images != nil) {
            return image;
        }
        
        CGImageRef imageRef = image.CGImage;
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
        BOOL anyAlpha = (alphaInfo == kCGImageAlphaLast || alphaInfo == kCGImageAlphaFirst
                         || alphaInfo == kCGImageAlphaPremultipliedFirst || alphaInfo == kCGImageAlphaPremultipliedLast);
        if (anyAlpha) {
            return image;
        }
        
        CGColorSpaceRef colorSpaceRef = CGImageGetColorSpace(imageRef);
        CGColorSpaceModel imageColorSpaceModel = CGColorSpaceGetModel(colorSpaceRef);
        BOOL unsupportedColorSpace = (imageColorSpaceModel == kCGColorSpaceModelUnknown ||
                                      imageColorSpaceModel == kCGColorSpaceModelMonochrome ||
                                      imageColorSpaceModel == kCGColorSpaceModelCMYK ||
                                      imageColorSpaceModel == kCGColorSpaceModelIndexed);
        if (unsupportedColorSpace) {
            colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        }
        
        size_t width = CGImageGetWidth(imageRef);
        size_t height = CGImageGetHeight(imageRef);
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = width * bytesPerPixel;
        NSUInteger bitsPerComponent = 8;
        
        CGContextRef context = CGBitmapContextCreate(NULL,
                                                     width,
                                                     height,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorSpaceRef,
                                                     kCGBitmapByteOrderDefault|kCGImageAlphaNoneSkipLast);
        
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        CGImageRef imageRefWithoutAlpha = CGBitmapContextCreateImage(context);
        UIImage *imageWithoutAlpha = [UIImage imageWithCGImage:imageRefWithoutAlpha scale:image.scale orientation:image.imageOrientation];
        
        if (unsupportedColorSpace) {
            CGColorSpaceRelease(colorSpaceRef);
        }
        
        CGContextRelease(context);
        CGImageRelease(imageRefWithoutAlpha);
        
        return imageWithoutAlpha;
    }
}

+ (NSInteger)imageTypeWithImageData:(NSData *)data
{
    return 0;
}

@end
