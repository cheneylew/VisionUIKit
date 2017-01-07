//
//  VSTitleDetailTableViewCell.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSBaseTableViewCell.h"
#import "VSTextField.h"
#import "VSTitleDetailTableViewCell.h"
#import <DJMacros/DJMacro.h>

@interface VSTBTitleFieldDataModel : VSTBTitleDetailDataModel

PP_STRONG(UIFont, titleFont)
PP_STRONG(UIColor, titleColor)

PP_STRONG(UIFont, fieldFont)
PP_STRONG(UIColor, fieldColor)


@end

@protocol VSTitleFieldTableViewCellDelegate <NSObject>

- (void)vs_titleFieldTableViewCellChangedText:(NSString *) text model:(VSTBBaseDataModel *) model;

@end

@interface VSTitleFieldTableViewCell : VSBaseTableViewCell

@property (nonatomic, strong) UILabel *vs_keyLabel;
@property (nonatomic, strong) VSTextField *vs_valueField;
@property (nonatomic, weak) id<VSTitleFieldTableViewCellDelegate> vs_delegate;

@end
