//
//  NVBaseProcessHandler.m
//  Navy
//
//  Created by Steven.Lin on 5/3/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVBaseProcessHandler.h"


@implementation NVBaseProcessHandler

+ (instancetype) defaultHandler {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void) execute:(id)data
         keyName:(NSString *)keyName
         success:(void (^)(id, NSString *))successBlock
         failure:(void (^)(id, NSString *))failureBlock {
    
}

@end
