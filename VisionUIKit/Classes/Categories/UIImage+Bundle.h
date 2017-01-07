//
//  UIImage+Bundle.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/7.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Bundle)

/**
 VisionUIKit.bundle中的图片资源
 
 @param name 图片名称
 @return UIImage
 */
+ (UIImage *)vs_imageName:(NSString *) name;

#pragma mark 通用方法



/**
 指定Bundle中查找图片
 
 @param name <#name description#>
 @param bundleName <#bundleName description#>
 @return <#return value description#>
 */
+ (UIImage *)vs_imageName:(NSString *) name bundleName:(NSString *) bundleName;

@end
