//
//  NVTableViewHeaderView.m
//  Navy
//
//  Created by Jelly on 9/24/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewHeaderView.h"




@implementation NVTableViewHeaderView

- (id) init {
    CGRect frame = CGRectMake(0.0f, 0.0f, APPLICATIONWIDTH, 20.0f);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor        = COLOR_HM_LIGHT_GRAY;
        
        self.uiTitle                = [[NVLabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, APPLICATIONWIDTH/2, 20.0f)];
        [self addSubview:self.uiTitle];
        self.uiTitle.font           = nvNormalFontWithSize(12.0f + fontScale);
        self.uiTitle.textColor      = COLOR_HM_BLACK;
    }
    
    return self;
}


+ (CGFloat) heightForView {
    return 20.0f;
}

@end

