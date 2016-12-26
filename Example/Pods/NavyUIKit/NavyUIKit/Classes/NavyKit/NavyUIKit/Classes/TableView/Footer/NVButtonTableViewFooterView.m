//
//  NVButtonFooterView.m
//  Navy
//
//  Created by Steven.Lin on 19/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVButtonTableViewFooterView.h"
#import "NVButtonTableViewCell.h"


@interface NVButtonTableViewFooterView ()
- (void) buttonAction:(id)sender;
@end


#define VIEW_HEIGHT (60.0f * displayScale)



@implementation NVButtonTableViewFooterView

- (id) init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        CALayer* line               = [CALayer layer];
        [self.layer addSublayer:line];
        line.backgroundColor        = COLOR_LINE.CGColor;
        line.frame                  = CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH, 0.5f);
        
        line               = [CALayer layer];
        [self.layer addSublayer:line];
        line.backgroundColor        = COLOR_LINE.CGColor;
        line.frame                  = CGRectMake(0.0f, VIEW_HEIGHT, APPLICATIONWIDTH, 0.5f);
        
        
        _button = [[NVButton alloc] initWithFrame:CGRectMake(20.0f*displayScale,
                                                             10.0f*displayScale,
                                                             APPLICATIONWIDTH - 40.0f*displayScale,
                                                             VIEW_HEIGHT - 20*displayScale)];
        [self addSubview:_button];
        _button.titleLabel.font         = nvNormalFontWithSize(18.0f + fontScale);
        _button.buttonStyle             = NVButtonStyleFilled;
        [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    
}

- (void) setObject:(id)object {
    [super setObject:object];
    
    NVButtonDataModel* dataModel = (NVButtonDataModel*)object;
    if ([dataModel.title length] > 0) {
        [_button setTitle:dataModel.title forState:UIControlStateNormal];
    }
    
    if (dataModel.titleColor) {
        [_button setTitleColor:dataModel.titleColor forState:UIControlStateNormal];
        [_button setTitleColor:dataModel.titleColor forState:UIControlStateHighlighted];
    }
    
    if (dataModel.fontSize > 0) {
        _button.titleLabel.font = nvNormalFontWithSize(dataModel.fontSize);
    }
    
    if (dataModel.backgroundColor) {
        _button.normalColor = dataModel.backgroundColor;
    }
    
    if (dataModel.disableColor) {
        _button.disableColor = dataModel.disableColor;
    }
    
    _button.buttonStyle = dataModel.style;
    _button.enabled     = dataModel.enable;
    
    dataModel.cellInstance = self;
    self.delegate = dataModel.delegate;
    
    if (dataModel.alignment == NVButtonAlignmentRight) {
        _button.frame = CGRectMake(APPLICATIONWIDTH - APPLICATIONWIDTH/3.0f, 0.0f, APPLICATIONWIDTH/3.0f, 20.0f);
    }

}

- (void) buttonAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickButtonTableViewFooterView:)]) {
        [self.delegate didClickButtonTableViewFooterView:self];
    }
}

+ (CGFloat) height {
    return VIEW_HEIGHT;
}

@end


