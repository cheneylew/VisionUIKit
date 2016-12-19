//
//  VSKeyValueTBVC.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSBaseTBVC.h"
#import "VSTextField.h"
#import "VSKeyValueTBVC.h"
#import <DJMacros/DJMacro.h>

@interface VSTBTitleFieldDataModel : VSTBKeyValueDataModel

PP_STRONG(UIFont, titleFont)
PP_STRONG(UIColor, titleColor)

PP_STRONG(UIFont, fieldFont)
PP_STRONG(UIColor, fieldColor)


@end

@interface VSTitleFieldTBVC : VSBaseTBVC

@property (nonatomic, strong) UILabel *vs_keyLabel;
@property (nonatomic, strong) VSTextField *vs_valueField;

@end