//
//  NVLabel.h
//  NavyUIKit
//
//  Created by Jelly on 6/23/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NVLabel : UILabel
@property (nonatomic, assign, readonly) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat width;
@end


/*!
 @class
 @abstract      画虚线的Label
 */
@interface NVDashLabel : NVLabel
@property (nonatomic, strong) UIColor* dashColor;

@end


@interface NVShadowLabel : NVLabel

@end

