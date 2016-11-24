//
//  VSTBViewConstructor.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBViewConstructor.h"
#import "VSTBKeyValueDataModel.h"
#import "VSTBIconTitleDataModel.h"
#import "VSTBDescDataModel.h"
#import "VSTBTitleTextFieldCell.h"
#import <DJMacros/DJMacro.h>

@implementation VSTBViewConstructor

- (void)addModels {
    
    
    {
        VSTBDataModel *model = [[VSTBDataModel alloc] init];
        model.classString = @"VSTBBlankCell";
        model.identifier = @"com.cell.a";
        model.backgroudColor = HEX(0xf5f5f5);
        model.height = NUM_FLOAT(12);
        [self.dataModels addObject:model];
    }
    {
        VSTBKeyValueDataModel *model = [[VSTBKeyValueDataModel alloc] init];
        model.classString = @"VSTBKeyValueTableViewCell";
        model.identifier = @"com.cell.b";
        model.groupLine = YES;
        model.height = NUM_FLOAT(35);
        model.key = @"标题";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        [self.dataModels addObject:model];
    }
    {
        VSTBIconTitleDataModel *model = [[VSTBIconTitleDataModel alloc] init];
        model.classString = @"VSTBIconTitleCell";
        model.identifier = @"com.cell.c";
        model.groupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.title = @"标题";
        model.imageName = @"weixin_pay_icon";
        model.detailArrowIcon = YES;
        [self.dataModels addObject:model];
    }
    
    {
        VSTBKeyValueDataModel *model = [[VSTBKeyValueDataModel alloc] init];
        model.classString = @"VSTBTitleTextFieldCell";
        model.identifier = @"com.cell.field";
        model.groupLine = YES;
        model.height = NUM_FLOAT(35);
        model.key = @"标题";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        [self.dataModels addObject:model];
    }
    
    {
        VSTBDataModel *model = [[VSTBDataModel alloc] init];
        model.classString = @"VSTBBlankCell";
        model.identifier = @"com.cell.d";
        model.backgroudColor = HEX(0xf5f5f5);
        model.height = NUM_FLOAT(12);
        [self.dataModels addObject:model];
    }
    
    {
        VSTBKeyValueDataModel *model = [[VSTBKeyValueDataModel alloc] init];
        model.classString = @"VSTBKeyValueTableViewCell";
        model.identifier = @"com.cell.b";
        model.height = NUM_FLOAT(35);
        model.key = @"标题";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        [self.dataModels addObject:model];
    }
    
    {
        VSTBDescDataModel *model = [[VSTBDescDataModel alloc] init];
        model.classString = @"VSTBDescCell";
        model.identifier = @"com.cell.aa";
        model.groupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.desc = @"据韩联社11月20日报道，韩国检方20日以涉嫌向各大企业施压索捐巨额资金为由起诉亲信门首犯崔顺实，检方在起诉书中指出朴槿惠涉嫌共谋作案，在毫无一官半职的崔顺实索捐和获得政府机密文件的过程中扮演重要角色。但由于韩国宪法第84条规定现任总统享有刑事豁免权，检方无法起诉朴槿惠。";
        model.font = [UIFont systemFontOfSize:12];
        model.textColor = [UIColor redColor];
        model.leftRightMargin = FIT6P(60);
        model.backgroudColor = HEX(0xefeff4);
        [self.dataModels addObject:model];
    }

}



@end
