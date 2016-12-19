//
//  VSKeyValueTBVC.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTitleFieldTBVC.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>
#import "VSKeyValueTBVC.h"
#import <ReactiveCocoa/UITextField+RACSignalSupport.h>
#import <ReactiveCocoa/RACSignal.h>

#define DEFTF_TITLE_COLOR   HEX(0x0b0b0b)
#define DEFTF_TITLE_FONT    [UIFont systemFontOfSize:FIT6P(47)]
#define DEFTF_FIELD_COLOR   HEX(0xa3a3a3)
#define DEFTF_FIELD_FONT    [UIFont systemFontOfSize:FIT6P(47)]

@implementation VSTBTitleFieldDataModel

@end

@implementation VSTitleFieldTBVC

- (void)initUI {
    [super initUI];
    UILabel *keyLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIT6P(60), 0, FIT6P(600), FIT6P(47))];
    keyLabel.textColor = DEFTF_TITLE_COLOR;
    keyLabel.font = DEFTF_TITLE_FONT;
    keyLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:keyLabel];
    self.vs_keyLabel = keyLabel;
    
    VSTextField *field = [[VSTextField alloc] initWithFrame:CGRectMake(0, 0, FIT6P(427), 28)];
    field.textColor = DEFTF_FIELD_COLOR;
    field.font = DEFTF_FIELD_FONT;
    field.right = self.width-FIT6P(96);
    field.textAlignment = NSTextAlignmentRight;
    field.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.contentView addSubview:field];
    self.vs_valueField = field;
    
    WEAK_SELF;
    [self.vs_valueField.rac_textSignal subscribeNext:^(NSString *text) {
        VSTBTitleFieldDataModel *dataModel = (VSTBTitleFieldDataModel *)weakself.cellModel;
        dataModel.value = text;
    }];
}

- (void)setModel:(VSTBBaseDataModel *)cellModel {
    [super setModel:cellModel];
    VSTBTitleFieldDataModel *model = (VSTBTitleFieldDataModel *) cellModel;
    ASSERT_NOT_NIL(model.height);
    self.vs_valueField.centerY = model.height.floatValue/2;
    self.vs_keyLabel.centerY = model.height.floatValue/2;
    self.vs_keyLabel.text = model.key;
    self.vs_valueField.text = model.value;
    
    if (model.titleColor) {
        self.vs_keyLabel.textColor = model.titleColor;
    }else {
        self.vs_keyLabel.textColor = DEFTF_TITLE_COLOR;
    }
    
    if (model.titleFont) {
        self.vs_keyLabel.font = model.titleFont;
    }else {
        self.vs_keyLabel.font = DEFTF_TITLE_FONT;
    }
    
    if (model.fieldColor) {
        self.vs_valueField.textColor = model.fieldColor;
    }else {
        self.vs_valueField.textColor = DEFTF_FIELD_COLOR;
    }
    
    if (model.fieldFont) {
        self.vs_valueField.font = model.fieldFont;
    }else {
        self.vs_valueField.font = DEFTF_FIELD_FONT;
    }
    
}

- (void)dealloc
{
    //DLog(@"VSTitleFieldTBVC dealloc");
}

@end
