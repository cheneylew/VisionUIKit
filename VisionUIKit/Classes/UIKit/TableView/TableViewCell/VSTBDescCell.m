//
//  VSTBDescCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBDescCell.h"
#import "VSTBDescDataModel.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

@implementation VSTBDescCell

- (void)initUI {
    [super initUI];
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6P(60), 0, FIT6P(427), FIT6P(42))];
    keyLabel.textColor = HEX(0x0b0b0b);
    keyLabel.font = [UIFont systemFontOfSize:FIT6P(44)];
    [self addSubview:keyLabel];
    self.vs_descLabel = keyLabel;
    
}

- (void)setCellModel:(VSTBDataModel *)cellModel {
    [super setCellModel:cellModel];
    VSTBDescDataModel *model = (VSTBDescDataModel *) cellModel;
    
    self.vs_descLabel.top = FIT6P(24);
    self.vs_descLabel.width = SCREEN_WIDTH - (model.leftRightMargin)*2.0f;
    self.vs_descLabel.left = model.leftRightMargin;
    self.vs_descLabel.height = [model.desc jk_heightWithFont:model.font
                                          constrainedToWidth:self.vs_descLabel.width];
    
    self.vs_descLabel.font = model.font;
    self.vs_descLabel.text = model.desc;
    self.vs_descLabel.numberOfLines = 0;
    model.height = NUM_FLOAT(FIT6P(24)*2.0f+self.vs_descLabel.height);
}


@end
