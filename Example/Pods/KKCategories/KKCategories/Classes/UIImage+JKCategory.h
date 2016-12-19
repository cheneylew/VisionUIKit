//
//  UIImage+Category.h
//  NavyUIKit
//
//  Created by Jelly on 6/22/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (nv_Category)
+ (UIImage*) nv_imageWithColor:(UIColor*)color;
+ (UIImage*) nv_grayscaleImage:(UIImage*)image;
- (UIImage*) nv_imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage*) nv_resizableImage:(UIEdgeInsets)insets;
- (UIImage*) nv_imageWithColor:(UIColor *)color;
+ (UIImage *) nv_imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *) nv_tintedImageWithColor:(UIColor*)color;

@end


@interface UIImage (nv_Blur)
- (UIImage *) nv_boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
@end


@interface UIImage (nv_ResizableImage)
- (UIImage*) nv_resizableImage:(UIEdgeInsets)insets;
@end

@interface UIImage (nv_Resize)
- (UIImage *)nv_imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)nv_resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)nv_resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)nv_resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)nv_transformForOrientation:(CGSize)newSize;

@end

@interface UIImage (JKCategory)

- (UIImage *)jk_scaleToSize:(CGSize)size;

@end
