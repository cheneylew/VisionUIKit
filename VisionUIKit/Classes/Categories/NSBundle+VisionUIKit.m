//
//  NSBundle+VisionUIKit.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/7.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "NSBundle+VisionUIKit.h"
#import <DJMacros/DJMacro.h>

@implementation NSBundle (VisionUIKit)

+ (instancetype)vs_sourceBundle
{
    static NSBundle *sourceBundle = nil;
    if (sourceBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        sourceBundle = [self vs_bundleName:@"VisionUIKit"];
    }
    return sourceBundle;
}

+ (NSBundle *)vs_bundleName:(NSString *) name {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:name ofType:@"bundle"]];
}




@end
