//
//  UIView+Screenshot.m
//  KKCategories
//
//  Created by Dejun Liu on 2016/11/13.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "UIView+Screenshot.h"

@implementation UIView (MotionEffect)

NSString *const centerX = @"center.x";
NSString *const centerY = @"center.y";

#pragma mark - Motion Effect
- (void)jk_addCenterMotionEffectsXYWithOffset:(CGFloat)offset {
    
    //    if(!IS_OS_7_OR_LATER) return;
    if(floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) return;
    
    UIInterpolatingMotionEffect *xAxis;
    UIInterpolatingMotionEffect *yAxis;
    
    xAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:centerX
                                                            type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    xAxis.maximumRelativeValue = @(offset);
    xAxis.minimumRelativeValue = @(-offset);
    
    yAxis = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:centerY
                                                            type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    yAxis.minimumRelativeValue = @(-offset);
    yAxis.maximumRelativeValue = @(offset);
    
    UIMotionEffectGroup *group = [[UIMotionEffectGroup alloc] init];
    group.motionEffects = @[xAxis, yAxis];
    
    [self addMotionEffect:group];
}

@end

@implementation UIView (Screenshot)

- (UIImage*) jk_screenshot {
    //WKWebView截图有问题
    //    UIGraphicsBeginImageContext(self.bounds.size);
    //    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    // helps w/ our colors when blurring
    //    // feel free to adjust jpeg quality (lower = higher perf)
    //    NSData *imageData = UIImageJPEGRepresentation(image, 0.75f);
    //    image = [UIImage imageWithData:imageData];
    
    //解决WKWebView截图问题
    CGRect rect = self.bounds;
    UIGraphicsBeginImageContext(rect.size);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

- (UIImage *) jk_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset {
    UIGraphicsBeginImageContext(self.bounds.size);
    //need to translate the context down to the current visible portion of the scrollview
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -contentOffset.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.55);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

- (UIImage*) jk_screenshotInFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), frame.origin.x, frame.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

@end
