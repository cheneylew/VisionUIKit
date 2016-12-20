//
//  NSMutableAttributedString+Category.m
//  DJMacros
//
//  Created by Dejun Liu on 2016/12/6.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "NSMutableAttributedString+DJCategory.h"

@implementation NSMutableAttributedString (DJCategory)

-(void)dj_addAttribute:(NSString *)name
                 value:(id)value
           toSubString:(NSString *)subString {
    NSRange range = [self.mutableString rangeOfString:subString options:NSCaseInsensitiveSearch];
    if (range.location != NSNotFound) {
        [self addAttribute:name value:value range:range];
    }
}

- (void)dj_appendString:(NSString *)string
         withAttributes:(NSDictionary *)attributes {
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:string
                                                                 attributes:attributes]];
}

- (void)dj_addLine:(NSUInteger)lines {
    NSString* line = [NSString string];
    for (NSInteger i = 0; i < lines; i++) {
        line = [line stringByAppendingString:@"\n"];
    }
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:line
                                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:6.0f]}]];
}

@end
