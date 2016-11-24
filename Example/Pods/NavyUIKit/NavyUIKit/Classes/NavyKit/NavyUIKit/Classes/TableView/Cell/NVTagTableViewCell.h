//
//  NVTagTableViewCell.h
//  Navy
//
//  Created by Jelly on 9/16/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"


@interface NVTagDataModel : NVDataModel
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, strong) UIColor* selectionColor;
@property (nonatomic, assign) BOOL selected;
@end


@interface NVTagTableViewCell : NVTableViewLineCell
- (void) updateDisplay;
@end


