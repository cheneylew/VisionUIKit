//
//  VSTBKeyValueTableViewCell.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBTableViewCell.h"
#import "VSTextField.h"

@interface VSTBTitleTextFieldCell : VSTBTableViewCell

@property (nonatomic, strong) UILabel *vs_keyLabel;
@property (nonatomic, strong) VSTextField *vs_valueField;

@end
