//
//  NSMutableAttributedString+Category.m
//  DJMacros
//
//  Created by Dejun Liu on 2016/12/6.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "NSMutableAttributedString+DJCategory.h"

@implementation NSMutableAttributedString (DJCategory)

-(void)dj_addAttribute:(NSString *)name value:(id)value string:(NSString *)string {
    NSRange range = [self.mutableString rangeOfString:string options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [self addAttribute:name value:value range:range];
    }
}

@end
