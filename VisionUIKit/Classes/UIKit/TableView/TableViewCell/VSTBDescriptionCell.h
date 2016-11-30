//
//  VSTBDescriptionCell.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBBaseCell.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

@interface VSTBDescriptionDataModel : VSTBBaseDataModel

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;


@property (nonatomic, assign) NSTextAlignment textAlignment;

PP_STRONG(NSNumber, leftRightMargin)
PP_STRONG(NSNumber, topMargin)
PP_STRONG(NSNumber, bottomMargin)

@end

@interface VSTBDescriptionCell : VSTBBaseCell

@property (nonatomic, strong) UILabel *vs_descLabel;

@end
