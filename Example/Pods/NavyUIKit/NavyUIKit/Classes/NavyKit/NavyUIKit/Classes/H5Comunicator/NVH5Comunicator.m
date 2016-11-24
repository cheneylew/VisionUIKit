//
//  HYCookieManager.m
//  Haiyinhui
//
//  Created by Dejun Liu on 2016/10/14.
//  Copyright © 2016年 Steven.Lin. All rights reserved.
//

#import "NVH5Comunicator.h"

#import "NavyUIKit.h"
#import "NVUtility.h"
#import "NVWebBrowserViewController.h"
//#import "AppManager.h"

#define kDEF_AES_PWD                            @"nQAi2alQIVqLtXeI"            //AES加解密Key
#define kDEF_USERID_COOKIE_KEY                  @"_m8k42bcDprEZceEU"           //用户ID的Cookie解密
#define kDEF_TOKEN_COOKIE_KEY                   @"_tZBWFNXKoZzFfVgq"           //用户Token的Cookie解密
#define kDEF_DEVICEID_KEY                       @"DQWRK4LVUGEXGZK1"
#define kDEF_UUID_KEY                           @"WOT5meBIr5CAile0"            //UUID KEY
#define kDEF_IS_NEED_DECODE_KEY                 @"rV7DVufssizJ8Slk"            //服务器用于判断webview的get请求是否需要解密用户ID和TOKEN
#define kDEF_IS_NEED_DECODE_VALUE               @"tqCeih5YpdJnNc33"            //

@implementation NVH5Comunicator

IMP_SINGLETON

- (void)startMonitor {

}

- (void)observeWebView {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(CheckUserIDAndTokenInCookies)
                                                 name:kNotificationWebViewControllerWillClosed
                                               object:nil];
}

- (void)CheckUserIDAndTokenInCookies {
    NSString *encodeUserIDStr     = [[self cookieValueWithKey:kDEF_USERID_COOKIE_KEY] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *encodeTokenStr   = [[self cookieValueWithKey:kDEF_TOKEN_COOKIE_KEY] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    if (encodeTokenStr && encodeUserIDStr) {
//        [self processEncodedInfoWithUserID:encodeUserIDStr token:encodeTokenStr];
    }
}


- (NSString *)cookieValueWithKey:(NSString *) key {
    NSArray *nCookies       = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSString *cookieValue    = nil;
    for (NSHTTPCookie *c in nCookies)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]]){
            NSLog(@"name:%@===value:%@===domain:%@===path:%@", c.name, c.value, c.domain,  c.path);
            if ([c.name isEqualToString:key]) {
                cookieValue = [c.value copy];
            }
        }
    }
    
    return cookieValue;
}

- (NSString *)AESKey {
    NSString *UUID  = [NVUtility uuid];
    NSString *md5   = [[[NSString stringWithFormat:@"%@%@", kDEF_AES_PWD, UUID] md5] lowercaseString];
    NSString *pwd   = [md5 substringWithRange:NSMakeRange(0, 16)];
    return pwd;
}

- (NSString *)getEncodedUUID {
    return [[NVUtility uuid] getAESEncrptyWithKey:kDEF_AES_PWD];
}

- (NSString *)decodedWithUUID:(NSString *) enUUID {
    return [enUUID getAESDecrptyWithKey:kDEF_AES_PWD];
}

- (NSString *)encodedUserID:(NSString *) userId {
    return [userId getAESEncrptyWithKey:[self AESKey]];
}

- (NSString *)decodeUserID:(NSString *) encodedUserId {
    return [encodedUserId getAESDecrptyWithKey:[self AESKey]];
}

- (NSString *)encodedToken:(NSString *) token {
    return [token getAESEncrptyWithKey:[self AESKey]];
}

- (NSString *)decodeToken:(NSString *) encodedToken {
    return [encodedToken getAESDecrptyWithKey:[self AESKey]];
}

- (NSString *)appendUserInfoWithURL:(NSString *) urlString
                             userid:(NSString *) userId
                              token:(NSString *) token {
    
    if (userId == nil || token == nil) {
        return urlString;
    }
    
    NSString *encodedUserID = [[NVH5Comunicator sharedInstance] encodedUserID:userId];
    NSString *encodedToken = [[NVH5Comunicator sharedInstance] encodedToken:token];
    NSString *encodedUUID = [[NVH5Comunicator sharedInstance] getEncodedUUID];
    
    NSString *resultStr = nil;
    if(![urlString containsString:@"?"]) {
        urlString = [urlString stringByAppendingString:@"?"];
    };
    resultStr = [NSString stringWithFormat:@"%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",
                 urlString,
                 kDEF_UUID_KEY,
                 [encodedUUID URLEncodedString],
                 kDEF_IS_NEED_DECODE_KEY,
                 kDEF_IS_NEED_DECODE_VALUE,
                 kDEF_USERID_COOKIE_KEY,
                 [encodedUserID URLEncodedString],
                 kDEF_TOKEN_COOKIE_KEY,
                 [encodedToken URLEncodedString],
                 @"device",
                 [@"iPhone OS" URLEncodedString]
                 ];
    return resultStr;
}

+ (void)CleanCookies {
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

+ (NSArray *)GetCookies {
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    return storage.cookies;
}

@end
