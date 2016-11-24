//
//  NVMenuItemView.h
//  Navy
//
//  Created by Jelly on 6/29/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVMenuItemView : UIButton
@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) UIEdgeInsets textEdgeInsets;
@property (nonatomic, strong) UIColor* normalColor;
@property (nonatomic, strong) UIColor* selectedColor;
@end
