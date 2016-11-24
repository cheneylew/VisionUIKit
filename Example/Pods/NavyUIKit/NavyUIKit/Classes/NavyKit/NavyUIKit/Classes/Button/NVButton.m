//
//  NVButton.m
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVButton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Category.h"
#import "Macros.h"


@interface NVButton ()

@end

@implementation NVButton


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //        [self setTitle:@"Button" forState:UIControlStateNormal];
        //        [self setTitleColor:COLOR_HM_LIGHT_BLACK forState:UIControlStateNormal];
        //        [self setTitleColor:COLOR_HM_GRAY forState:UIControlStateDisabled];
        //        [self setTitleColor:COLOR_HM_BLACK forState:UIControlStateHighlighted];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2.0f;
        self.enabled = YES;

        _layerBackground                = [CALayer layer];
        [self.layer insertSublayer:self.layerBackground atIndex:0];
//        self.layerBackground.frame          = self.bounds;
        self.layerBackground.masksToBounds  = YES;
        self.layerBackground.cornerRadius   = 2.0f;

        self.disableColor                   = COLOR_HM_LIGHT_GRAY;
    }
    
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.layerBackground.frame          = self.bounds;
}

- (void) setButtonStyle:(NVButtonStyle)buttonStyle {
    _buttonStyle = buttonStyle;
    
    switch (_buttonStyle) {
        case NVButtonStyleFilled:
            [self.layerBackground setBackgroundColor:self.normalColor.CGColor];
            [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            self.layer.borderColor = [UIColor clearColor].CGColor;
//            self.layer.borderWidth = 0.0f;
            break;
            
        case NVButtonStyleBorder:
            self.layerBackground.backgroundColor        = [UIColor colorWithWhite:1.0f alpha:0.2f].CGColor;
            self.layerBackground.borderColor            = self.normalColor.CGColor;
            self.layerBackground.borderWidth            = 1.0f;
            self.layerBackground.cornerRadius           = 2.0f;
            self.layerBackground.masksToBounds          = YES;
            break;
            
        default:
            break;
    }

}


- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        
        if (self.buttonStyle == NVButtonStyleFilled) {
            UIColor* color = [UIColor colorRGBonvertToHSB:self.normalColor withBrighnessDelta:0.1f];
            [self.layerBackground setBackgroundColor:color.CGColor];
            
        } else if (self.buttonStyle == NVButtonStyleBorder) {
            UIColor* color = [UIColor colorRGBonvertToHSB:[UIColor colorWithWhite:1.0f alpha:0.2f] withBrighnessDelta:-0.2f];
            [self.layerBackground setBackgroundColor:color.CGColor];
            
        }
    } else {
        if (self.buttonStyle == NVButtonStyleFilled) {
            [self.layerBackground setBackgroundColor:self.normalColor.CGColor];
            
        } else if (self.buttonStyle == NVButtonStyleBorder) {
            [self.layerBackground setBackgroundColor:[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor];
            
        }
    }
}

- (void) setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (enabled) {
        self.buttonStyle = _buttonStyle;
    } else {
        if (self.buttonStyle == NVButtonStyleFilled) {
            [self.layerBackground setBackgroundColor:self.disableColor.CGColor];
            
        } else {
            [self.layerBackground setBackgroundColor:[UIColor clearColor].CGColor];
            
        }
        
    }
    
}


@end
