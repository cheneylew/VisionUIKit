//
//  VSTBKeyValueTableViewCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBTitleTextFieldCell.h"
#import "VSTBKeyValueDataModel.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

@implementation VSTBTitleTextFieldCell

- (void)initUI {
    [super initUI];
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6P(60), 0, FIT6P(427), FIT6P(42))];
    keyLabel.textColor = HEX(0x0b0b0b);
    keyLabel.font = [UIFont systemFontOfSize:FIT6P(44)];
    [self addSubview:keyLabel];
    self.vs_keyLabel = keyLabel;
    
    VSTextField *field = [[VSTextField alloc] initWithFrame:CGRectMake(0, 0, FIT6P(427), 26)];
    field.textColor = HEX(0xa3a3a3);
    field.font = [UIFont systemFontOfSize:FIT6P(44)];
    field.right = self.width-FIT6P(96);
    field.textAlignment = NSTextAlignmentRight;
    field.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:field];
    self.vs_valueField = field;
}

- (void)setCellModel:(VSTBDataModel *)cellModel {
    [super setCellModel:cellModel];
    VSTBKeyValueDataModel *model = (VSTBKeyValueDataModel *) cellModel;
    ASSERT_NOT_NIL(model.height);
    self.vs_valueField.centerY = model.height.floatValue/2;
    self.vs_keyLabel.centerY = model.height.floatValue/2;
    self.vs_keyLabel.text = model.key;
    self.vs_valueField.text = model.value;
}

@end
