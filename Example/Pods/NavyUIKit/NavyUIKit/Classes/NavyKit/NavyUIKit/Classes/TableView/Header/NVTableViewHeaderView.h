//
//  NVTableViewHeaderView.h
//  Navy
//
//  Created by Jelly on 9/24/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavyUIKit.h"


@interface NVTableViewHeaderView : UIView
@property (nonatomic, strong) NVLabel* uiTitle;

+ (CGFloat) heightForView;

@end
