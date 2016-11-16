//
//  UIColor+HibuSearch.m
//  BIPV10
//
//  Created by Tom York on 03/06/2013.
//  Copyright (c) 2013 Hibu (UK) Limited. All rights reserved.
//

#import "UIColor+HEX.h"

@implementation UIColor (HEX)

+ (UIColor*)colorWithHex:(NSInteger)hexColor alpha:(CGFloat) alpha
{
    const NSInteger red = (hexColor & 0xFF0000) >> 16;
    const NSInteger green = (hexColor & 0x00FF00) >> 8;
    const NSInteger blue = (hexColor & 0x0000FF);
    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:alpha];
}

+ (UIColor*)color256WithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue
{
    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0f];
}

+ (UIColor*)color256WithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:alpha];
}

@end
