//
//  NVViewController.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVViewController.h"

@implementation NVViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            break;
        case UIInterfaceOrientationLandscapeLeft:
            frame.size = CGSizeMake(frame.size.height, frame.size.width);
            break;
        case UIInterfaceOrientationLandscapeRight:
            frame.size = CGSizeMake(frame.size.height, frame.size.width);
            break;
        default:
            break;
    }
    
    [self decorateRotateToInterfaceOrientation:toInterfaceOrientation duration:duration withRotationRect:frame];
}

- (void) decorateRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration withRotationRect:(CGRect)rect {
    
}



@end
