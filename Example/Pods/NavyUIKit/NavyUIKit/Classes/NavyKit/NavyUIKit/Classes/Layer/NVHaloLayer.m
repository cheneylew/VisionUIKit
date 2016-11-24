//
//  NVHaloLayer.m
//  Navy
//
//  Created by Jelly on 9/18/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVHaloLayer.h"
#import <UIKit/UIKit.h>


@interface NVHaloLayer ()
@property (nonatomic, strong) CAAnimationGroup *animationGroup;
@end


@implementation NVHaloLayer


- (id) init {
    self = [super init];
    if (self) {
        
        self.contentsScale = [UIScreen mainScreen].scale;
        self.opacity = 0;
        
        self.radius = 60.0f;
        self.animationDuration = 3.0f;
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f].CGColor;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            
            [self setupAnimationGroup];
            
        });
    }
    
    return self;
}


- (void) setRadius:(CGFloat)radius {
    _radius = radius;
    
    CGPoint tempPos = self.position;
    
    CGFloat diameter = self.radius * 2;
    
    self.bounds = CGRectMake(0.0f, 0.0f, diameter, diameter);
    self.cornerRadius = self.radius;
    self.position = tempPos;
}

- (void)setupAnimationGroup  {
    CAMediaTimingFunction *defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    self.animationGroup = [CAAnimationGroup animation];
    self.animationGroup.duration = self.animationDuration;
    self.animationGroup.repeatCount = INFINITY;
    self.animationGroup.removedOnCompletion = NO;
    self.animationGroup.timingFunction = defaultCurve;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.xy"];
    scaleAnimation.fromValue = @0.0;
    scaleAnimation.toValue = @1.0;
    scaleAnimation.duration = self.animationDuration;
    
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = self.animationDuration;
    opacityAnimation.values = @[@0.45, @0.45, @0];
    opacityAnimation.keyTimes = @[@0, @0.2, @1];
    opacityAnimation.removedOnCompletion = NO;
    
    NSArray *animations = @[scaleAnimation, opacityAnimation];
    
    self.animationGroup.animations = animations;
}

@end
