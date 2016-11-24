//
//  NSString+Category.m
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>


#define LENGTH_VERIFY_CODE          6


@implementation NSString (Category)

- (BOOL) isValidMobileNumber {
    NSString* const MOBILE = @"^1(3|4|5|7|8)\\d{9}$";

    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidVerifyCode {
    
    NSString* const VERIFYCODE = [NSString stringWithFormat:@"^d{%d}$", LENGTH_VERIFY_CODE];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VERIFYCODE];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidBankCardNumber {
    NSString* const BANKCARD = @"^(\\d{15}|\\d{16}|\\d{17}|\\d{18}|\\d{19}|\\d{20})$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", BANKCARD];
    return [predicate evaluateWithObject:self];
}


//留两位小数的带有逗号的字符串
+ (NSString*) stringFormatCurrencyWithDouble:(double)currency {
    NSString* value = [NSString stringWithFormat:@"%.02f", currency];
    
    NSMutableString* string     = [[NSMutableString alloc] init];
    [string appendString:[value substringFromIndex:[value length] - 3]];
    
    NSInteger index = [value length] - 6;
    while (index > 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(index, 3)];
        [string insertString:subValue atIndex:0];
        [string insertString:@"," atIndex:0];
        
        index -= 3;
    }
    
    if (index <= 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(0, 3 + index)];
        [string insertString:subValue atIndex:0];
    }
    
    return string;
}

+ (NSString *)stringFormatCurrencyToIntegerWithDouble:(double)currency{
    NSString *string = [NSString stringFormatCurrencyWithDouble:currency];
    string = [string componentsSeparatedByString:@"."].firstObject;
    
    return string;
}

+ (NSString*) stringFormatJPYCurrencyWithDouble:(double)currency {
    NSString* value = [NSString stringWithFormat:@"%.0f", currency];;
    
    
    NSMutableString* string     = [[NSMutableString alloc] init];
    
    NSInteger index = [value length] - 3;
    while (index > 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(index, 3)];
        [string insertString:subValue atIndex:0];
        [string insertString:@"," atIndex:0];
        
        index -= 3;
    }
    
    if (index <= 0) {
        NSString* subValue = [value substringWithRange:NSMakeRange(0, 3 + index)];
        [string insertString:subValue atIndex:0];
    }
    
    return string;
}


+ (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

- (NSString*) stringValue {
    return self;
}

- (NSString*) toBankStyleString {
    NSString *cardNum = [self removeWhiteSpace];
    if (cardNum.length == 0) {
        return @"";
    }
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i<cardNum.length; i++) {
        unichar c = [cardNum characterAtIndex:i];
        NSString *cString = [NSString stringWithCharacters:&c length:1];
        [result appendString:cString];
        if ((i+1) % 4 == 0) {
            if (i != result.length) {
                [result appendString:@" "];
            }
        }
    }
    return result;
}

- (NSString*) removeWhiteSpace {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}


- (BOOL) isValidIdentityCard {
    NSString* const IDENTITY = @"^\\d{18,18}|\\d{15,15}|\\d{17,17}x)*$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidEmailAddress {
    if ([self rangeOfString:@"@"].length > 0) {
        if ([self rangeOfString:@"."].length > 0) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) isValidChinese {
    NSString* const IDENTITY = @"^[\u4e00-\u9fa5]*$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isName {
    NSString* const NAME = @"^[\u4e00-\u9fa5]*$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NAME];
    return [predicate evaluateWithObject:self];
}

- (BOOL) isValidZip {
    NSString* const IDENTITY = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}


- (BOOL) hasExistedSpace {
    return ([self rangeOfString:@" "].length > 0);
}

- (BOOL) isValidAmount {
    NSString* const IDENTITY = @"^(([1-9]\\d{0,9})|0)(\\.\\d{0,2})?$";
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDENTITY];
    return [predicate evaluateWithObject:self];
}

@end



@implementation NSString (urlEncode)

- (NSString *)URLEncodedChineseString {
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLDecodedChineseString {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

@end



static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

@implementation NSString (Base64)

+ (NSString *)base64StringFromData:(NSData *)data length:(NSUInteger)length {
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1) {
        return @"";
    }
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0) {
            break;
        }
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext) {
                input[i] = raw[ix];
            }
            else {
                input[i] = 0;
            }
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++) {
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        }
        
        for (i = ctcopy; i < 4; i++) {
            [result appendString: @"="];
        }
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length)) {
            charsonline = 0;
        }
    }     
    return result;
}

@end


@implementation NSString (Format)

+ (NSString*) stringMobileFormat:(NSString *)mobile {
    if ([mobile isValidMobileNumber]) {
        NSMutableString* value = [[NSMutableString alloc] initWithString:mobile];
        [value insertString:@" " atIndex:3];
        [value insertString:@" " atIndex:8];
        return value;
    }
    
    return nil;
}


+ (NSString*) stringChineseFormat:(double)value{
    
    if (value / 100000000.0f >= 1) {
        return [NSString stringWithFormat:@"%.2f亿", value / 100000000.0f];
    }
    else if (value / 10000.0f >= 1 && value / 100000000.0f < 1) {
        return [NSString stringWithFormat:@"%.2f万", value / 10000.0f];
    }
    else {
        return [NSString stringWithFormat:@"%.2f", value];
    }

}


@end




@implementation NSString (MD5)

- (NSString*) md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],result[4],result[5],
            result[6],result[7],result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15]];
}

@end




@implementation NSString (UrlParameters)

- (NSDictionary*) parameters {
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    NSArray* array          = [self componentsSeparatedByString:@"&"];
    
    [array enumerateObjectsUsingBlock:^(NSString*  _Nonnull value, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([value containsString:@"="]) {
            NSRange range = [value rangeOfString:@"="];
            NSString *key = [value substringWithRange:NSMakeRange(0, range.location)];
            NSString *val = [value substringWithRange:NSMakeRange(range.location+1, value.length - range.location - 1)];
            [parameters setObject:val forKey:key];
        }
    }];
    
    return parameters;
}

- (NSArray*) parametersSorted {
    NSMutableArray* parameters      = [NSMutableArray array];
    NSArray* array                  = [self componentsSeparatedByString:@"&"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* keyValues          = [(NSString*)obj componentsSeparatedByString:@"="];
        
        if (keyValues.count > 1) {
            [parameters addObject:@{keyValues[0]: keyValues[1]}];
        }
    }];
    
    return parameters;
}


- (NSDictionary*)jsonPatameters
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    NSArray* array          = [self componentsSeparatedByString:@"&"];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray* keyValues  = [(NSString*)obj componentsSeparatedByString:@"="];
        NSString* string = keyValues[1];
        string = [string stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
        
        NSArray* arr = [string componentsSeparatedByString:@"\""];
        __block NSMutableArray* mutArr = [NSMutableArray array];
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* str = (NSString*)obj;
            if ([str containsString:@"http"]) {
                [mutArr addObject:str];
            };
        }];
        [parameters setObject:mutArr forKey:keyValues[0]];
    }];
    
    return parameters;
}

@end




@implementation NSString (Date)
+ (NSString*) stringFromDate:(NSDate*)date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString* string = [formatter stringFromDate:date];
    
    return string;
}

@end




