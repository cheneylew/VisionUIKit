//
//  NVButtonTableViewCell.m
//  NavyUIKit
//
//  Created by Jelly on 6/22/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#define CELL_HEIGHT     (60.0f * nativeScale() / 2)

#import "NVButtonTableViewCell.h"

@implementation NVButtonDataModel


- (id) init {
    self = [super init];
    if (self) {
        self.style = NVButtonStyleFilled;
        self.enable = YES;
        self.radius = 3.0f;
        self.btnWidth = @(APPLICATIONWIDTH - 40.0f*displayScale);
        self.btnHeight = @(CELL_HEIGHT - 20*displayScale);
    }
    
    return self;
}

- (void) setEnable:(BOOL)enable {
    _enable = enable;
    
    if (self.cellInstance) {
        NVButtonTableViewCell* cell = (NVButtonTableViewCell*)self.cellInstance;
        cell.button.enabled         = enable;
    }
}

@end


@interface NVButtonTableViewCell ()
- (void) buttonAction:(id)sender;
@end


@implementation NVButtonTableViewCell


- (void)initUI {
    [super initUI];
    
    [self setBackgroundColor:[UIColor clearColor]];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _button = [[NVButton alloc] initWithFrame:CGRectMake(20.0f*displayScale,
                                                         10.0f*displayScale,
                                                         APPLICATIONWIDTH - 40.0f*displayScale,
                                                         CELL_HEIGHT - 20*displayScale)];
    [self.contentView addSubview:_button];
    _button.titleLabel.font         = nvNormalFontWithSize(18.0f + fontScale);
    _button.buttonStyle             = NVButtonStyleFilled;
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (void) setObject:(id)object {
    [super setObject:object];
    
    self.item.normalBackgroudColor = self.item.normalBackgroudColor?self.item.normalBackgroudColor:[UIColor clearColor];
    self.backgroundColor = self.item.normalBackgroudColor;
    
    NVButtonDataModel* dataModel = (NVButtonDataModel*)self.item;
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
    
    _button.layer.cornerRadius = dataModel.radius;
    _button.layerBackground.cornerRadius = dataModel.radius;
    
    _button.height = dataModel.btnHeight.floatValue;
    _button.width = dataModel.btnWidth.floatValue;
    
    if (dataModel.alignment == NVButtonAlignmentRight) {
        _button.frame = CGRectMake(APPLICATIONWIDTH - APPLICATIONWIDTH/3.0f, 0.0f, APPLICATIONWIDTH/3.0f, 20.0f);
    } else {
        _button.centerX =   self.width/2;
    }
    
    if (dataModel.shadowColor) {
        _button.layer.shadowOffset =  CGSizeMake(1, FIT6(8));
        _button.layer.shadowOpacity = 0.2;
        _button.layer.shadowColor =  dataModel.shadowColor.CGColor;
        _button.clipsToBounds = NO;
    } else {
        _button.clipsToBounds = YES;
        _button.layer.shadowOpacity = 0.0;
    }
}

- (void) buttonAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickButtonTableViewCell:)]) {
        [self.delegate didClickButtonTableViewCell:self];
    }
}

+ (CGFloat) heightForCell {
    return CELL_HEIGHT;
}


@end



