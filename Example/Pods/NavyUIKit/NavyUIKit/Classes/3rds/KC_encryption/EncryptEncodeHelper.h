//
//  EncryptOperator.h
//  KC_encryption
//
//  Created by Kennix on 7/6/2015.
//  Copyright (c) 2015年 kennix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Encrypt)

- (NSString *)getAESEncrptyWithKey:(NSString *)key;
- (NSString *)getAESDecrptyWithKey:(NSString *)key;
- (NSString *)base64Encode;
- (NSString *)base64Decode;


@end


@interface NSString (Encode)

- (NSString *)md5;
- (NSString *)urlEncode;
- (NSString *)urlDecode;

@end
