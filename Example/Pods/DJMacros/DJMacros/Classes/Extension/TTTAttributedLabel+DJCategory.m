//
//  TTTAttributedLabel+DJCategory.m
//  DJMacros
//
//  Created by Dejun Liu on 2016/12/6.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "TTTAttributedLabel+DJCategory.h"

@implementation TTTAttributedLabel (DJCategory)

- (TTTAttributedLabelLink *)dj_addLinkToURLString:(NSString *)urlString
                                        subString:(NSString *)subString {
    NSRange range = [self.text rangeOfString:subString];
    if (range.location != NSNotFound) {
        return [self addLinkToURL:[NSURL URLWithString:urlString] withRange:range];
    }else {
        return nil;
    }
}

- (TTTAttributedLabelLink *)dj_addLinkToPhoneNumber:(NSString *)phoneNumber
                                          subString:(NSString *)subString {
    NSRange range = [self.text rangeOfString:subString];
    if (range.location != NSNotFound) {
        return [self addLinkToPhoneNumber:phoneNumber withRange:range];
    }else {
        return nil;
    }
}

- (TTTAttributedLabelLink *)dj_addLinkToDate:(NSDate *)date
                                   subString:(NSString *)subString {
    NSRange range = [self.text rangeOfString:subString];
    if (range.location != NSNotFound) {
        return [self addLinkToDate:date withRange:range];
    }else {
        return nil;
    }
}



@end
