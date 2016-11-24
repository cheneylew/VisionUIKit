//
//  NSData+Category.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Base64)
+ (NSData *)base64DataFromString:(NSString *)string;
@end
