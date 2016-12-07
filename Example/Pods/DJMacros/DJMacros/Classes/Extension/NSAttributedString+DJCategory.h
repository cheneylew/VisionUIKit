//
//  NSAttributedString+DJCategory.h
//  DJMacros
//
//  Created by Dejun Liu on 2016/12/6.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (DJCategory)

- (CGFloat)dj_heightWithWidth:(CGFloat) width;
- (CGFloat)dj_widthWithHeight:(CGFloat) height;

@end
