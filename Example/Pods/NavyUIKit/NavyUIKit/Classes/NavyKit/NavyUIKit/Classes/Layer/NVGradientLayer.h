//
//  NVGradientLayer.h
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>



/*!
 @class
 @abstract      渐变色的Layer，继承CALayer
 */
@interface NVGradientLayer : CALayer

/*!
 @property
 @abstract      设置渐变颜色的数组，上下渐变
 */
@property (nonatomic, strong, readonly) NSMutableArray* arrayColors;

/*!
 @function
 @abstract      添加一个颜色
 */
- (void) addColor:(UIColor*)color;
- (void) removeColors;
@end

