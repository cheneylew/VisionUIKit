//
//  VSTBKeyValueTableViewCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBKeyValueTableViewCell.h"
#import "VSTBKeyValueDataModel.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

@implementation VSTBKeyValueTableViewCell

- (void)initUI {
    [super initUI];
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6P(60), 0, FIT6P(427), FIT6P(42))];
    keyLabel.textColor = HEX(0x0b0b0b);
    keyLabel.font = [UIFont systemFontOfSize:FIT6P(44)];
    [self addSubview:keyLabel];
    self.vs_keyLabel = keyLabel;
    
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, FIT6P(427), FIT6P(42))];
    valueLabel.textColor = HEX(0xa3a3a3);
    valueLabel.font = [UIFont systemFontOfSize:FIT6P(44)];
    valueLabel.right = self.width-FIT6P(96);
    valueLabel.textAlignment = NSTextAlignmentRight;
    valueLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self addSubview:valueLabel];
    self.vs_valueLabel = valueLabel;
}

- (void)setCellModel:(VSTBDataModel *)cellModel {
    [super setCellModel:cellModel];
    VSTBKeyValueDataModel *model = (VSTBKeyValueDataModel *) cellModel;
    ASSERT_NOT_NIL(model.height);
    CGFloat top = (model.height.floatValue-self.vs_valueLabel.height)/2;
    self.vs_valueLabel.top = top;
    self.vs_keyLabel.top = top;
    self.vs_keyLabel.text = model.key;
    self.vs_valueLabel.text = model.value;
}

@end
