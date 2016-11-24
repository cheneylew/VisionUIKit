//
//  VSTBIconTitleCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBIconTitleCell.h"
#import "VSTBIconTitleDataModel.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

@implementation VSTBIconTitleCell

- (void)initUI {
    [super initUI];
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6P(60), 0, FIT6P(427), FIT6P(42))];
    keyLabel.textColor = HEX(0x0b0b0b);
    keyLabel.font = [UIFont systemFontOfSize:FIT6P(44)];
    [self addSubview:keyLabel];
    self.vs_keyLabel = keyLabel;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, FIT6P(72), FIT6P(72))];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.vs_iconImageView = imageView;
    [self addSubview:imageView];
}

- (void)setCellModel:(VSTBDataModel *)cellModel {
    [super setCellModel:cellModel];
    VSTBIconTitleDataModel *model = (VSTBIconTitleDataModel *) cellModel;
    
    self.vs_iconImageView.centerY = model.height.floatValue/2;
    self.vs_iconImageView.left  = FIT6P(62);
    self.vs_iconImageView.image = [UIImage imageNamed:model.imageName];
    
    self.vs_keyLabel.left = self.vs_iconImageView.right+FIT6P(54);
    self.vs_keyLabel.centerY = model.height.floatValue/2;
    self.vs_keyLabel.text = model.title;
}

@end
