//
//  NVUtility.m
//  Navy
//
//  Created by Jelly on 7/9/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVUtility.h"

@implementation NVUtility

+ (NSString *)appUrlScheme {
    NSString * urlScheme = nil;
    
    NSArray * schemes    = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    
    for (NSDictionary * scheme in schemes) {
        NSString * identifier       = [scheme objectForKey:@"CFBundleURLName"];
        if (identifier && [identifier isEqualToString:[NVUtility appBundleId]]) {
            NSArray * items         = [scheme objectForKey:@"CFBundleURLSchemes"];
            if (items && items.count) {
                urlScheme           = [items objectAtIndex:0];
            }
        }
    }
    
    NSLog(@"%@", urlScheme);
    return urlScheme;
}

+ (NSString*) appBundleId {
    NSString * bundleId = nil;
    
    bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    
    NSLog(@"%@", bundleId);
    return bundleId;
}

+ (NSString*) appVersion {
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString*) osVersion {
    NSString* osVersion = [[UIDevice currentDevice] systemVersion];
    return osVersion;
}

+ (NSString*) deviceInfo {
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
}

+ (NSString*) uuid {
    NSString* uuid = [UIDevice currentDevice].identifierForVendor.UUIDString;
    return uuid;
}

@end
