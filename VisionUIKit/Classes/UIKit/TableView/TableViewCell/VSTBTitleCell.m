//
//  VSTBDescriptionCell.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBTitleCell.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

@implementation VSTBTitleDataModel


@end

@implementation VSTBTitleCell

- (void)initUI {
    [super initUI];
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6P(60), 0, FIT6P(427), FIT6P(42))];
    keyLabel.textColor = HEX(0x0b0b0b);
    keyLabel.font = [UIFont systemFontOfSize:FIT6P(44)];
    [self addSubview:keyLabel];
    self.vs_descLabel = keyLabel;
    
}

- (void)setModel:(VSTBBaseDataModel *)cellModel {
    VSTBTitleDataModel *model = (VSTBTitleDataModel *) cellModel;
    
    self.vs_descLabel.top = model.topMargin?model.topMargin.floatValue:FIT6P(24);
    self.vs_descLabel.width = SCREEN_WIDTH - (model.leftRightMargin.floatValue)*2.0f;
    self.vs_descLabel.left = model.leftRightMargin.floatValue;
    self.vs_descLabel.height = [model.desc jk_heightWithFont:model.font
                                          constrainedToWidth:self.vs_descLabel.width];
    
    self.vs_descLabel.font = model.font;
    self.vs_descLabel.text = model.desc;
    self.vs_descLabel.textColor = model.textColor?model.textColor:[UIColor darkGrayColor];
    self.vs_descLabel.numberOfLines = 0;
    CGFloat bottomMargin = model.bottomMargin?model.bottomMargin.floatValue:FIT6P(24);
    model.height = NUM_FLOAT(self.vs_descLabel.top+self.vs_descLabel.height+bottomMargin);
    
    self.vs_descLabel.textAlignment = model.textAlignment;
    
    [super setModel:cellModel];
}


@end
