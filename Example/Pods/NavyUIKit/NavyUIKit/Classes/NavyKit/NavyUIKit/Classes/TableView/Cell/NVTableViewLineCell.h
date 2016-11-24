//
//  NVTableViewLineCell.h
//  NavyUIKit
//
//  Created by Jelly on 6/21/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//


#import "NVTableViewCell.h"
#import "NVNoAnimationLayer.h"


/*!
 @class
 @abstract      画顶部和底部线的TableViewCell。继承PATableViewCell
 */
@interface NVTableViewLineCell : NVTableViewCell
@property (nonatomic, strong) NVNoAnimationLayer* lineUpper;
@property (nonatomic, strong) NVNoAnimationLayer* lineLower;
@end



#define CLS_TABLE_VIEW_INDENT_LINE_CELL         @"PATableViewIndentLineCell"

/*!
 @class
 @abstract      画顶部和底部缩进线的TableViewCell。继承PATableViewCell
 */
@interface NVTableViewIndentLineCell : NVTableViewLineCell

@end


