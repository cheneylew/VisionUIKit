//
//  NSMutableAttributedString+Category.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Category)
- (void) appendString:(NSString *)string withAttributes:(NSDictionary *)attributes;
- (void) addLine:(NSUInteger)lines;
@end
