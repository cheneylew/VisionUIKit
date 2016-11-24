//
//  NVButtonTableViewCell.m
//  NavyUIKit
//
//  Created by Jelly on 6/22/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVButtonTableViewCell.h"

@implementation NVButtonDataModel


- (id) init {
    self = [super init];
    if (self) {
        self.style = NVButtonStyleFilled;
        self.enable = YES;
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



#define CELL_HEIGHT     (60.0f * nativeScale() / 2)

@interface NVButtonTableViewCell ()
- (void) buttonAction:(id)sender;
@end


@implementation NVButtonTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
    
    return self;
}


- (void) setObject:(id)object {
    if (self.item != object && object != nil) {
        self.item = object;
    }
    
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
    
    if (dataModel.alignment == NVButtonAlignmentRight) {
        _button.frame = CGRectMake(APPLICATIONWIDTH - APPLICATIONWIDTH/3.0f, 0.0f, APPLICATIONWIDTH/3.0f, 20.0f);
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



