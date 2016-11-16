//
//  UIColor+HibuSearch.h
//  BIPV10
//
//  Created by Tom York on 03/06/2013.
//  Copyright (c) 2013 Hibu (UK) Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HEX)

/**
 Returns a color from a HTML/CSS style color specification expressed as an integer.
 @param hexColor An integer representing a color. You can use hex format to express web colors, e.g. 0xAABBCC.
 @return A UIColor represented by the color specification or nil if it was invalid.  The alpha value is set to 100%.
 */
+ (UIColor*)colorWithHex:(NSInteger)hexColor alpha:(CGFloat)alpha;
+ (UIColor*)color256WithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor*)color256WithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end
