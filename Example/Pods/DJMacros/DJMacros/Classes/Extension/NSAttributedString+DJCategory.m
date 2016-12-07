//
//  NSAttributedString+DJCategory.m
//  DJMacros
//
//  Created by Dejun Liu on 2016/12/6.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "NSAttributedString+DJCategory.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@implementation NSAttributedString (DJCategory)

- (CGFloat)dj_heightWithWidth:(CGFloat) width {
    return [TTTAttributedLabel sizeThatFitsAttributedString:self withConstraints:CGSizeMake(width, MAXFLOAT) limitedToNumberOfLines:0].height;
}

- (CGFloat)dj_widthWithHeight:(CGFloat) height {
    return [TTTAttributedLabel sizeThatFitsAttributedString:self withConstraints:CGSizeMake(MAXFLOAT, height) limitedToNumberOfLines:0].width;
}


@end
