//
//  NSBundle+VisionUIKit.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/7.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (VisionUIKit)

#pragma mark 仅限于VisionUIKit.bundle中查找资源

/**
 VisionUIKit的资源文件位置

 @return bundle位置
 */
+ (instancetype)vs_sourceBundle;

/**
 Main Bundle中查找指定的Bundle
 
 @param name <#name description#>
 @return <#return value description#>
 */
+ (NSBundle *)vs_bundleName:(NSString *) name;


@end
