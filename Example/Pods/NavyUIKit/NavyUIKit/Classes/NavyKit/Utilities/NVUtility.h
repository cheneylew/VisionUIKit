//
//  NVUtility.h
//  Navy
//
//  Created by Jelly on 7/9/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define kURLSchemeIdnentifier                           @"hyh"


@interface NVUtility : NSObject

+ (NSString*) appUrlScheme;
+ (NSString*) appBundleId;
+ (NSString*) appVersion;
+ (NSString*) osVersion;
+ (NSString*) deviceInfo;
+ (NSString*) uuid;

@end
