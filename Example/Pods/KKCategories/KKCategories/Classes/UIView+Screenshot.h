//
//  UIView+Screenshot.h
//  KKCategories
//
//  Created by Dejun Liu on 2016/11/13.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (MotionEffect)
- (void) jk_addCenterMotionEffectsXYWithOffset:(CGFloat)offset;
@end

@interface UIView (Screenshot)

- (UIImage*) jk_screenshot;
- (UIImage*) jk_screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;
- (UIImage*) jk_screenshotInFrame:(CGRect)frame;

@end
