//
//  UIView+Category.h
//  NavyUIKit
//
//  Created by Jelly on 6/22/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (MotionEffect)
- (void) addCenterMotionEffectsXYWithOffset:(CGFloat)offset;
@end


@interface UIView (Shake)
- (void) shakeAnimation;
@end


@interface UIView (Screenshot)
- (UIImage*) screenshot;
- (UIImage*) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;
- (UIImage*) screenshotInFrame:(CGRect)frame;
@end



@interface UIView (Keyboard)
+ (void) closeKeyboard;
@end
