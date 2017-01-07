//
//  UIImage+Bundle.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/7.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "UIImage+Bundle.h"
#import <DJMacros/DJMacro.h>
#import "NSBundle+VisionUIKit.h"

@implementation UIImage (Bundle)

+ (UIImage *)vs_imageName:(NSString *) name {
    return [self vs_imageName:name bundle:[NSBundle vs_sourceBundle]];
}

+ (UIImage *)vs_imageName:(NSString *) name bundleName:(NSString *) bundleName {
    return [self vs_imageName:name bundle:[NSBundle vs_bundleName:bundleName]];
}

+ (UIImage *)vs_imageName:(NSString *) name bundle:(NSBundle *) bundle {
    NSString *rawName = name;
    NSString *x2Name = [NSString stringWithFormat:@"%@@2x", name];
    NSString *x3Name = [NSString stringWithFormat:@"%@@3x", name];
    
    NSString *rawPath = [bundle pathForResource:rawName ofType:@"png"];
    NSString *x2Path = [bundle pathForResource:x2Name ofType:@"png"];
    NSString *x3Path = [bundle pathForResource:x3Name ofType:@"png"];
    
    NSString *resultPath = nil;
    if (iPhone6OrSmaller) {
        if (x2Path) {
            resultPath = x2Path;
        } else {
            resultPath = rawPath;
        }
    } else {
        if (x3Path) {
            resultPath = x3Path;
        } else {
            if (x2Path) {
                resultPath = x2Path;
            } else {
                resultPath = rawPath;
            }
        }
    }
    return [[UIImage imageWithContentsOfFile:resultPath]
            imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
