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
-(void)dj_addAttribute:(NSString *)name value:(id)value string:(NSString *)string;

@end
