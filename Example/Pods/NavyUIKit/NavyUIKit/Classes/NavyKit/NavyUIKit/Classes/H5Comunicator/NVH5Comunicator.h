//
//  HYCookieManager.h
//  Haiyinhui
//
//  Created by Dejun Liu on 2016/10/14.
//  Copyright © 2016年 Steven.Lin. All rights reserved.
//
//
//  单例模式，用来监控当UIWebView关闭的时候，检查Cookie中服务器存的token和userId，对其进行解密
//
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"

@interface NVH5Comunicator : NSObject

DEF_SINGLETON(NVH5Comunicator)

/**
 *  开始监控Cookie中用户ID和Token的情况
 */
- (void)startMonitor;

/**
 *  提供给H5 JS动态调用获取
 *
 *  @return 加密后的UUID
 */
- (NSString *)getEncodedUUID;
//- (NSString *)decodeUUID:(NSString *) enUUID;

//- (NSString *)encodeUserID:(NSString *) userId;
- (NSString *)decodeUserID:(NSString *) encodedUserId;

//- (NSString *)encodeToken:(NSString *) token;
- (NSString *)decodeToken:(NSString *) encodedToken;


/**
 将URL字符串拼接用户信息

 @param urlString 需要拼接的目标URL
 @param userId    用户ID
 @param token     用户Token

 @return 拼接后的URL
 */
- (NSString *)appendUserInfoWithURL:(NSString *) urlString
                             userid:(NSString *) userId
                              token:(NSString *) token;



+ (void)CleanCookies;
+ (NSArray *)GetCookies;


@end
