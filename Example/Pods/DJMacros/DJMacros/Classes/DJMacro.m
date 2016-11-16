//
//  DJMacro.m
//  DJMacros
//
//  Created by Dejun Liu on 2016/11/11.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "DJMacro.h"

CGSize getScreenSize()
{
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size = [[UIScreen mainScreen] bounds].size;
    });
    return size;
}
