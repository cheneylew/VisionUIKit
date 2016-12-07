//
//  NSMutableAttributedString+Category.m
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NSMutableAttributedString+Category.h"
#import "Navy.h"


@implementation NSMutableAttributedString (Category)

- (void) appendString:(NSString *)string withAttributes:(NSDictionary *)attributes {
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:string
                                                                 attributes:attributes]];
}

- (void) addLine:(NSUInteger)lines {
    NSString* line = [NSString string];
    for (NSInteger i = 0; i < lines; i++) {
        line = [line stringByAppendingString:@"\n"];
    }
    [self appendAttributedString:[[NSAttributedString alloc] initWithString:line
                                                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}]];
}

@end


