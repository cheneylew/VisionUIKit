//
//  VSTBButtonCell.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/27.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBBaseCell.h"
#import <DJMacros/DJMacro.h>

@interface VSTBButtonDataModel : VSTBBaseDataModel

PP_STRONG(UIColor,  button_normal_color)
PP_STRONG(UIColor,  button_hightlight_color)
PP_STRONG(UIColor,  button_title_color)
PP_STRONG(UIFont,   button_title_font)
PP_STRONG(NSString, button_title)

@end

@protocol VSTBButtonCellDelegate <NSObject>

- (void)VSTBButtonCellWithButtonClickEvent:(UIButton *) btn model:(VSTBBaseDataModel *) model;

@end

@interface VSTBButtonCell : VSTBBaseCell

@property (nonatomic, weak) id<VSTBButtonCellDelegate> delegate;

@end
