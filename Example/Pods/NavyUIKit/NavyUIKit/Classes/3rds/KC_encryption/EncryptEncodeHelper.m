//
//  EncryptOperator.m
//  KC_encryption
//
//  Created by Kennix on 7/6/2015.
//  Copyright (c) 2015年 kennix. All rights reserved.
//

#import "EncryptEncodeHelper.h"
#import "AES.h"
#import <CommonCrypto/CommonCrypto.h>
#import "Base64.h"


@implementation NSString (Encrypt)

- (NSString *)getAESEncrptyWithKey:(NSString *)key{
    NSMutableData *query_data = [NSMutableData dataWithData:[self dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *date = [query_data AES128EncryptWithKey:key];
    NSString *encryptedStr = ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)?[date base64EncodedStringWithOptions:0]:[Base64 encodeBase64WithData:date];
    query_data = nil;
    return encryptedStr;
}

- (NSString *)getAESDecrptyWithKey:(NSString *)key{
    NSMutableData *decodedData = ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0)?[[NSMutableData alloc] initWithBase64EncodedString:self options:0]:[NSMutableData dataWithData:[Base64 decodeBase64WithString:self]];
    NSData *data = [decodedData AES128DecryptWithKey:key];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)base64Encode{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [plainData base64EncodedStringWithOptions:0];
}

- (NSString *)base64Decode{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}

@end


@implementation NSString (Encode)

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)urlEncode{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    return result;
}

- (NSString *)urlDecode{
    return (__bridge NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                         (__bridge CFStringRef) self,
                                                                                         CFSTR(""),
                                                                                         kCFStringEncodingUTF8);
}

@end



