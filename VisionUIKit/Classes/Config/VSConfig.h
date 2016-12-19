//
//  VSConfig.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>

#define VSCFG_API_BASE_URL @"http://localhost/"


@interface VSConfig : NSObject

SINGLETON_ITF(VSConfig)

PP_STRONG(NSURL, APIBaseURL)

@end
