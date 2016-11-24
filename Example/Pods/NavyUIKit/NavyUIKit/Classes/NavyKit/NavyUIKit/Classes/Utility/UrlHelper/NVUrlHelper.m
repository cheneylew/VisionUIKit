//
//  NVUrlHelper.m
//  Navy
//
//  Created by Jelly on 8/11/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVUrlHelper.h"



@implementation NVUrlHelper
IMP_SINGLETON


- (BOOL) hasAppUrlSchema:(NSString*)urlSchema {
    urlSchema   = [urlSchema lowercaseString];
    if ([urlSchema isEqualToString:@"hyhapp"]) {
        return YES;
    }
    
    return NO;
}

@end
