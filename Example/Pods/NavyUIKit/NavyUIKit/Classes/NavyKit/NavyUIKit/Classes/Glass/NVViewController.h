//
//  NVViewController.h
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVViewController : UIViewController
- (void) decorateRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                     duration:(NSTimeInterval)duration
                             withRotationRect:(CGRect)rect;
@end
