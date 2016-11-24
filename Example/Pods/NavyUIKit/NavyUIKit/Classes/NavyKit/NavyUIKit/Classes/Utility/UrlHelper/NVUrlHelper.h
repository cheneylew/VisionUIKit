//
//  NVUrlHelper.h
//  Navy
//
//  Created by Jelly on 8/11/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"


@interface NVUrlHelper : NSObject
DEF_SINGLETON(NVUrlHelper)

- (BOOL) hasAppUrlSchema:(NSString*)urlSchema;

@end
