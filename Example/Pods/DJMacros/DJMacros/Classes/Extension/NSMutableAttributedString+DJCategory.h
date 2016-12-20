//
//  NSMutableAttributedString+Category.h
//  DJMacros
//
//  Created by Dejun Liu on 2016/12/6.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (DJCategory)


/**
 对某个字符串，设置样式

 @param name  <#name description#>
 @param value <#value description#>
 @param words <#words description#>
 */
-(void)dj_addAttribute:(NSString *)name
                 value:(id)value
           toSubString:(NSString *)subString;


/**
 拼接字符串

 @param string     <#string description#>
 @param attributes <#attributes description#>
 */
- (void)dj_appendString:(NSString *)string
         withAttributes:(NSDictionary *)attributes;

/**
 换行

 @param lines 行数
 */
- (void)dj_addLine:(NSUInteger)lines;

@end
