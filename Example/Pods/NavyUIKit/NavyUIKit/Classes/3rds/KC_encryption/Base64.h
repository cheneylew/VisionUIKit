//
//  Base64.h
//  KC_encryption
//
//  Created by Kennix on 7/6/2015.
//  Copyright (c) 2015年 kennix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+ (NSString *)encodeBase64WithData:(NSData *)objData;
+ (NSData *)decodeBase64WithString:(NSString *)base64Str;

@end
