//
//  NVLabel.m
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVLabel.h"
#import <QuartzCore/QuartzCore.h>

@implementation NVLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFont:[UIFont fontWithName:@"STHeitiSC-Medium" size:14.0f]];
        //        [self setTextColor:[UIColor whiteColor]];
    }
    return self;
}

- (CGFloat) height {
    return self.bounds.size.height;
}

- (CGFloat) width {
    return self.bounds.size.width;
}

@end


@implementation NVDashLabel


- (void) drawRect:(CGRect)rect {
    
    CGContextRef context =  UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, (_dashColor == nil) ? [UIColor blackColor].CGColor : _dashColor.CGColor);
    
    CGFloat lengths[] = {5.0f, 5.0f};
    CGContextSetLineDash(context, 0.0f, lengths, 2.0f);
    CGContextMoveToPoint(context, 0.0f, (self.frame.size.height - 0.5f)/2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextStrokePath(context);
    
    CGContextClosePath(context);
    
    [self setBackgroundColor:[UIColor clearColor]];
}

@end


@implementation NVShadowLabel

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.layer.shadowRadius = 3.0f;
    self.layer.shadowOpacity = 0.5f;
}

@end



