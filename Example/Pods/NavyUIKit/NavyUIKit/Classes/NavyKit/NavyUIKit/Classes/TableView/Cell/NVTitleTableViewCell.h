//
//  NVTitleTableViewCell.h
//  Navy
//
//  Created by Jelly on 6/28/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NavyUIKit.h"


@interface NVTitleDataModel : NVDataModel
@property (nonatomic, strong) id title;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) CGFloat fontSize;
@end


@interface NVTitleTableViewCell : NVTableViewNullCell
- (void) updateDisplay;
@end


