//
//  TTTAttributedLabel+DJCategory.h
//  DJMacros
//
//  Created by Dejun Liu on 2016/12/6.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface TTTAttributedLabel (DJCategory)

- (TTTAttributedLabelLink *)dj_addLinkToURLString:(NSString *)urlString
                                        subString:(NSString *)subString;
- (TTTAttributedLabelLink *)dj_addLinkToPhoneNumber:(NSString *)phoneNumber
                                          subString:(NSString *)subString;
- (TTTAttributedLabelLink *)dj_addLinkToDate:(NSDate *)date
                                   subString:(NSString *)subString;

@end
