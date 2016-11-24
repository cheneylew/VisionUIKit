//
//  NVHaloLayer.h
//  Navy
//
//  Created by Jelly on 9/18/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface NVHaloLayer : CALayer
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@end
