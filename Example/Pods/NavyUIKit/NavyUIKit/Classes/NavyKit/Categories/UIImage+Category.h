//
//  UIImage+Category.h
//  NavyUIKit
//
//  Created by Jelly on 6/22/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (Category)
+ (UIImage*) imageWithColor:(UIColor*)color;
+ (UIImage*) grayscaleImage:(UIImage*)image;
- (UIImage*) imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage*) resizableImage:(UIEdgeInsets)insets;
- (UIImage*) imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)tintedImageWithColor:(UIColor*)color;

@end


@interface UIImage (Blur)
- (UIImage *) boxblurImageWithBlur:(CGFloat)blur exclusionPath:(UIBezierPath *)exclusionPath;
@end


@interface UIImage (ResizableImage)
- (UIImage*) resizableImage:(UIEdgeInsets)insets;
@end

@interface UIImage (Resize)
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

@end


@interface UIImage (ImageEffects)
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyBlurEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;
@end


@interface UIImage (Compressed)
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;
@end
