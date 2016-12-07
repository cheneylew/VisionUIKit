//
//  UIColor+Category.h
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JKCategory)
+ (UIColor*) nv_colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta;
+ (UIColor*) nv_colorRGBonvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta;
@end
