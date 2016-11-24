//
//  NVBorderLabel.m
//  Navy
//
//  Created by Jelly on 7/2/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVBorderLabel.h"
#import "UIColor+Category.h"
#import "Macros.h"


@implementation NVBorderLabel


- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.masksToBounds    = YES;
        self.layer.borderWidth      = 1.0f;
        
        self.font                   = nvNormalFontWithSize(14);
        self.textAlignment          = NSTextAlignmentCenter;
    }
    
    return self;
}

- (void) setBorderColor:(UIColor *)borderColor {
    self.textColor                  = borderColor;
    self.layer.borderColor          = borderColor.CGColor;
    self.backgroundColor            = [UIColor clearColor];//[UIColor colorRGBonvertToHSB:borderColor withBrighnessDelta:0.2f];
}

- (void) sizeToFit {
    [super sizeToFit];
    
    CGRect bound        = self.bounds;
    bound.size.width    += 4.0f * displayScale;
    bound.size.height   += 2.0f * displayScale;
    self.bounds         = bound;
}

@end
