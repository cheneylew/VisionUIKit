//
//  NVFloatingTextField.m
//  Navy
//
//  Created by Jelly on 8/31/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVFloatingTextField.h"
#import "NVLabel.h"
#import "Macros.h"




@interface NVFloatingTextField ()
@property (nonatomic, strong) NVLabel* uiFloatingLabel;
@property (nonatomic, assign) NSUInteger stateOfFloating;
- (void) showFloatingLabel;
- (void) hideFloatingLabel;
@end


@implementation NVFloatingTextField


- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        self.uiFloatingLabel            = [[NVLabel alloc] init];
        self.fontOfPlaceholder          = nvNormalFontWithSize(16.0f + fontScale);
        self.uiFloatingLabel.textColor  = COLOR_HM_GRAY;
        [self addSubview:self.uiFloatingLabel];
        
        
    }
    
    return self;
}


- (void) setFontOfPlaceholder:(UIFont *)fontOfPlaceholder {
    _fontOfPlaceholder = fontOfPlaceholder;
    
    self.uiFloatingLabel.font = _fontOfPlaceholder;
}


- (void) setPlaceholder:(NSString *)placeholder {
    self.uiFloatingLabel.text       = placeholder;
    [self.uiFloatingLabel sizeToFit];
    
    CGFloat x = 0.0f;
    if (self.textAlignment == NSTextAlignmentCenter) {
        x = (self.frame.size.width - self.uiFloatingLabel.frame.size.width) / 2;
    } else if (self.textAlignment == NSTextAlignmentRight) {
        x = self.frame.size.width - self.uiFloatingLabel.frame.size.width;
    }
    
    
    self.uiFloatingLabel.frame = CGRectMake(x,
                                            self.frame.size.height - self.uiFloatingLabel.font.lineHeight,
                                            self.uiFloatingLabel.frame.size.width,
                                            self.uiFloatingLabel.frame.size.height);
}


- (void) layoutSubviews {
    [super layoutSubviews];
    
    if (self.isFirstResponder) {
        if (self.text == nil || [self.text length] == 0) {
            [self hideFloatingLabel];
        } else {
            [self showFloatingLabel];
        }
        
    } else {
        
    }
}


- (CGRect) textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super textRectForBounds:bounds], UIEdgeInsetsMake(self.uiFloatingLabel.font.lineHeight,
                                                                                    0.0f,
                                                                                    0.0f,
                                                                                    0.0f));
}

- (CGRect) editingRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect([super editingRectForBounds:bounds], UIEdgeInsetsMake(self.uiFloatingLabel.font.lineHeight,
                                                                                       0.0f,
                                                                                       0.0f,
                                                                                       0.0f));
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    rect = CGRectMake(rect.origin.x,
                      rect.origin.y + self.uiFloatingLabel.font.lineHeight / 2.0f,
                      rect.size.width,
                      rect.size.height);
    return rect;
}


- (void) showFloatingLabel {
    
    if (self.stateOfFloating == 1) {
        return;
    }
    self.stateOfFloating = 1;
    
    __block CGRect frame = CGRectMake(0.0f,
                              self.frame.size.height - self.uiFloatingLabel.font.lineHeight,
                              self.uiFloatingLabel.frame.size.width,
                              self.uiFloatingLabel.frame.size.height);
    self.uiFloatingLabel.frame = frame;
    self.fontOfPlaceholder = self.fontOfPlaceholder;
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         
                         frame.origin.y -= 5.0f;
                         self.uiFloatingLabel.frame = frame;
                         self.uiFloatingLabel.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         [self setLabelOriginForTextAlignment];
                         
                         self.uiFloatingLabel.textColor = COLOR_HM_BLACK;
                         self.uiFloatingLabel.font   = nvNormalFontWithSize(12.0f + fontScale);
                         
                         [UIView animateWithDuration:0.45f
                                               delay:0.0f
                                             options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              self.uiFloatingLabel.alpha = 1.0f;
                             
                                              self.uiFloatingLabel.frame = CGRectMake(self.uiFloatingLabel.frame.origin.x,
                                                                                      2.0f,
                                                                                      self.uiFloatingLabel.frame.size.width,
                                                                                      self.uiFloatingLabel.frame.size.height);
                                          }
                                          completion:^(BOOL finished) {
                                              
                                          }];
                     }];
}

- (void) hideFloatingLabel {

    if (self.stateOfFloating == 0) {
        return;
    }
    self.stateOfFloating = 0;
    
    [self setLabelOriginForTextAlignment];
    
    __block CGRect frame = self.uiFloatingLabel.frame;
    self.uiFloatingLabel.textColor  = COLOR_HM_BLACK;
    self.uiFloatingLabel.font       = nvNormalFontWithSize(12.0f + fontScale);
    
    [UIView animateKeyframesWithDuration:0.45f
                                   delay:0.0f
                                 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseOut
                              animations:^{
                                  
                                  frame.origin.y += 5.0f;
                                  self.uiFloatingLabel.frame = frame;
                                  self.uiFloatingLabel.alpha = 0.0f;
                              }
                              completion:^(BOOL finished) {
                                  
                                  self.uiFloatingLabel.textColor = COLOR_HM_GRAY;
                                  self.fontOfPlaceholder = self.fontOfPlaceholder;

                                  [UIView animateWithDuration:0.45f
                                                        delay:0.0f
                                                      options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                                                   animations:^{
                                                       self.uiFloatingLabel.alpha = 1.0f;
                                                       
                                                       frame.origin.y = self.frame.size.height - self.uiFloatingLabel.font.lineHeight;
                                                       self.uiFloatingLabel.frame = frame;
                                                   }
                                                   completion:^(BOOL finished) {
                                                       
                                                   }];

                                  
                              }];
}


- (void)setLabelOriginForTextAlignment
{
    CGFloat x = self.uiFloatingLabel.frame.origin.x;
    if (self.textAlignment == NSTextAlignmentCenter) {
        x = (self.frame.size.width - self.uiFloatingLabel.frame.size.width) / 2;
    } else if (self.textAlignment == NSTextAlignmentRight) {
        x = self.frame.size.width - self.uiFloatingLabel.frame.size.width;
    }
    
    self.uiFloatingLabel.frame = CGRectMake(x,
                                            self.uiFloatingLabel.frame.origin.y,
                                            self.uiFloatingLabel.frame.size.width,
                                            self.uiFloatingLabel.frame.size.height);
}


@end
