//
//  NavyUIKit.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "Macros.h"


UIFont* navigationTitleFont() {
    return navigationTitleFontWithSize(19.0f);
}

UIFont* navigationTitleFontWithSize(CGFloat size) {
    UIFont* font = FONT_HELVETICA_NEUE_LIGHT_SIZE(size);
    if (font == nil) {
        font = FONT_HELVETICA_NEUE_ULTRA_LIGHT_SIZE(size);
    }
    
    return font;
}

CGFloat nativeScale(void) {
    static CGFloat scale = 0.0f;
    if (scale == 0.0f) {
        CGFloat width = APPLICATIONWIDTH;
        scale = width / 320.0f;
    }
    return scale * 2;
}


