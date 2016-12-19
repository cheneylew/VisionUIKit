//
//  VSConfig.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSConfig.h"

@implementation VSConfig

SINGLETON_IMPL(VSConfig)

- (NSURL *)APIBaseURL {
    if (_APIBaseURL == nil) {
        _APIBaseURL = [NSURL URLWithString:VSCFG_API_BASE_URL];
    }
    return _APIBaseURL;
}

@end
