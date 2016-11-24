//
//  NVSheetView.m
//  xiaochunlaile
//
//  Created by Steven.Lin on 6/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVSheetView.h"
#import "NavyUIKit.h"


@interface NVSheetView ()
@property (nonatomic, strong) NVLabel* uiTitle;
@property (nonatomic, strong) NVLabel* uiValue;
@end


@implementation NVSheetView


- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor            = [UIColor clearColor];
        
        CGSize size                     = frame.size;
        
        self.uiTitle                    = [[NVLabel alloc] initWithFrame:CGRectMake(0.0f,
                                                                                    0.0f,
                                                                                    size.width/3,
                                                                                    size.height)];
        [self addSubview:self.uiTitle];
        self.uiTitle.font               = nvNormalFontWithSize(14.0f + fontScale);
        self.uiTitle.textAlignment      = NSTextAlignmentLeft;
        self.uiTitle.textColor          = COLOR_HM_LIGHT_BLACK;
        self.uiTitle.numberOfLines      = 0;
        
        
        self.uiValue                    = [[NVLabel alloc] initWithFrame:CGRectMake(size.width/3,
                                                                                    0.0f,
                                                                                    size.width/3*2,
                                                                                    size.height)];
        [self addSubview:self.uiValue];
        self.uiValue.font               = nvNormalFontWithSize(14.0f + fontScale);
        self.uiValue.textAlignment      = NSTextAlignmentLeft;
        self.uiValue.textColor          = COLOR_HM_LIGHT_BLACK;
        self.uiValue.numberOfLines      = 0;

        
    }
    
    return self;
}


- (void) setTitle:(id)title {
    _title = title;
    
    CGSize size     = self.frame.size;
    CGSize szText   = CGSizeZero;
    if ([title isKindOfClass:[NSString class]]) {
        self.uiTitle.text               = title;
        szText = [self.title boundingRectWithSize:CGSizeMake(size.width/3, 1000000.0f)
                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                              attributes:ATTR_DICTIONARY(COLOR_HM_LIGHT_BLACK, 14.0f + fontScale)
                                                 context:nil].size;
    } else if ([title isKindOfClass:[NSAttributedString class]]) {
        self.uiTitle.attributedText     = title;
        szText = [self.uiTitle.attributedText boundingRectWithSize:CGSizeMake(size.width/3, 1000000.0f)
                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                           context:nil].size;
    }
    
    CGRect frame        = self.uiTitle.frame;
    frame.size.height   = szText.height + 20.0f;
    self.uiTitle.frame  = frame;
    
    frame               = self.frame;
    frame.size.height   = szText.height + 20.0f;
    self.frame          = frame;
}

- (void) setValue:(id)value {
    _value = value;
    
    CGSize size     = self.frame.size;
    CGSize szText   = CGSizeZero;
    if ([value isKindOfClass:[NSString class]]) {
        self.uiValue.text               = value;
        szText = [self.value boundingRectWithSize:CGSizeMake(size.width/3*2, 1000000.0f)
                                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       attributes:ATTR_DICTIONARY(COLOR_HM_LIGHT_BLACK, 16.0f + fontScale)
                                          context:nil].size;
    } else if ([value isKindOfClass:[NSAttributedString class]]) {
        self.uiValue.attributedText     = value;
        
        szText = [self.uiValue.attributedText boundingRectWithSize:CGSizeMake(size.width/3*2, 1000000.0f)
                                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                           context:nil].size;
    }
    
    CGRect frame        = self.uiValue.frame;
    frame.size.height   = szText.height + 20.0f;
    self.uiValue.frame  = frame;
    
    frame               = self.frame;
    frame.size.height   = szText.height + 20.0f;
    self.frame          = frame;
}

- (void) setValueAlignment:(NSTextAlignment)valueAlignment {
    _valueAlignment = valueAlignment;
    
    self.uiValue.textAlignment  = valueAlignment;
}

- (void) setValueColor:(UIColor *)valueColor {
    _valueColor = valueColor;
    self.uiValue.textColor      = valueColor;
}

@end



