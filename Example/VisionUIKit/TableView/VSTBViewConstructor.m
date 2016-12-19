//
//  VSTBViewConstructor.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBViewConstructor.h"
#import "VSKeyValueTBVC.h"
#import "VSTitleFieldTBVC.h"
#import "VSEmptyTBVC.h"
#import "VSTitleTBVC.h"
#import "VSTitleImageTBVC.h"
#import "VSButtonTBVC.h"
#import <DJMacros/DJMacro.h>
#import <ReactiveCocoa/NSObject+RACPropertySubscribing.h>
#import <ReactiveCocoa/RACSignal.h>
#import <KKCategories/UIColor+JKCategory.h>

@implementation VSTBViewConstructor

- (void)addModels {
    
    {
        VSTBButtonDataModel *model = [[VSTBButtonDataModel alloc] init];
        model.classString = @"VSButtonTBVC";
        model.identifier = @"com.navi.hidden";
        model.height = NUM_FLOAT(60);
        model.detailArrowIcon = NO;
        
        model.button_title_font = [UIFont systemFontOfSize:16];
        model.button_title = @"隐藏NavigationBar";
        model.button_normal_color = HEX(0x09bb07);
        model.button_hightlight_color = [UIColor nv_colorRGBonvertToHSB:HEX(0x09bb07) withAlphaDelta:-0.2f];
        
        [self.dataModels addObject:model];
    }
    
    {
        VSTBBaseDataModel *model = [[VSTBBaseDataModel alloc] init];
        model.classString = @"VSEmptyTBVC";
        model.identifier = @"com.cell.a";
        model.backgroudColor = HEX(0xf5f5f5);
        model.height = NUM_FLOAT(12);
        
        [self.dataModels addObject:model];
    }
    {
        VSTBKeyValueDataModel *model = [[VSTBKeyValueDataModel alloc] init];
        model.classString = @"VSKeyValueTBVC";
        model.identifier = @"com.cell.b";
        model.showGroupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.key = @"上下分割线";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        model.selectedStyle = VSTBCellSelectedStyleCustom;
        model.showTopLine = YES;
        model.showBottomLine = YES;
        [self.dataModels addObject:model];
    }
    
    {
        VSTBBaseDataModel *model = [[VSTBBaseDataModel alloc] init];
        model.classString = @"VSEmptyTBVC";
        model.identifier = @"com.cell.a";
        model.backgroudColor = HEX(0xf5f5f5);
        model.height = NUM_FLOAT(12);
        
        [self.dataModels addObject:model];
    }
    
    {
        VSTBKeyValueDataModel *model = [[VSTBKeyValueDataModel alloc] init];
        model.classString = @"VSKeyValueTBVC";
        model.identifier = @"com.cell.b11";
        model.showGroupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.key = @"自定义分组线";
        model.value = @"2.0 元";
        model.selectedStyle = VSTBCellSelectedStyleNone;
        
        model.showGroupLine = YES;
        model.groupLineColor = HEX(0x09bb07);
        model.groupLineLeft = NUM_FLOAT(10);
        [self.dataModels addObject:model];
    }
    
    {
        VSTBTitleIconDataModel *model = [[VSTBTitleIconDataModel alloc] init];
        model.classString = @"VSTitleImageTBVC";
        model.identifier = @"com.cell.c";
        model.showGroupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.title = @"点击标题 可修改";
        model.imageName = @"weixin_pay_icon";
        model.detailArrowIcon = YES;
        [self.dataModels addObject:model];
    }
    
    {
        VSTBTitleFieldDataModel *modelA = [[VSTBTitleFieldDataModel alloc] init];
        modelA.classString = @"VSTitleFieldTBVC";
        modelA.identifier = @"com.cell.field1";
        modelA.showGroupLine = YES;
        modelA.height = NUM_FLOAT(FIT6P(133));
        modelA.key = @"数据绑定-被绑定对象";
        modelA.detailArrowIcon = YES;
        modelA.value = @"这里将改变";
        modelA.fieldColor = [UIColor redColor];
        modelA.fieldFont = [UIFont systemFontOfSize:18];
        [self.dataModels addObject:modelA];
        
        VSTBTitleFieldDataModel *modelB = [[VSTBTitleFieldDataModel alloc] init];
        modelB.classString = @"VSTitleFieldTBVC";
        modelB.identifier = @"com.cell.field1";
        modelB.showGroupLine = YES;
        modelB.height = NUM_FLOAT(FIT6P(133));
        modelB.key = @"数据绑定-触发对象";
        modelB.detailArrowIcon = YES;
        modelB.value = @"修改这里";
        [self.dataModels addObject:modelB];
        
        
        WEAK(modelA);
        WEAK_SELF;
        [RACObserve(modelB, value) subscribeNext:^(id x) {
            DLog(@"%@",x);
            weakmodelA.value = x;
            [weakself.TB reloadRowsAtIndexPaths:@[[self indexPathOfModel:modelA]]
                               withRowAnimation:UITableViewRowAnimationFade];
            //[weakself.TB reloadData];
        }];
        
    }
    
    for (int i=0; i<2; i++) {
        {
            VSTBTitleFieldDataModel *model = [[VSTBTitleFieldDataModel alloc] init];
            model.classString = @"VSTitleFieldTBVC";
            model.identifier = @"com.cell.field1";
            model.showGroupLine = YES;
            model.height = NUM_FLOAT(FIT6P(133));
            model.key = @"field";
            model.detailArrowIcon = YES;
            model.value = [NSString stringWithFormat:@"2.0 元 %d",i];
            [self.dataModels addObject:model];
        }
    }
    
    {
        VSTBBaseDataModel *model = [[VSTBBaseDataModel alloc] init];
        model.classString = @"VSEmptyTBVC";
        model.identifier = @"com.cell.d";
        model.backgroudColor = HEX(0xf5f5f5);
        model.height = NUM_FLOAT(12);
        [self.dataModels addObject:model];
    }
    
    {
        VSTBKeyValueDataModel *model = [[VSTBKeyValueDataModel alloc] init];
        model.classString = @"VSKeyValueTBVC";
        model.identifier = @"com.cell.b";
        model.height = NUM_FLOAT(FIT6P(133));
        model.key = @"标题";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        [self.dataModels addObject:model];
    }
    
    {
        VSTBTitleDataModel *model = [[VSTBTitleDataModel alloc] init];
        model.classString = @"VSTitleTBVC";
        model.identifier = @"com.cell.aa";
        model.showGroupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.desc = @"据韩联社11月20日报道，韩国检方20日以涉嫌向各大企业施压索捐巨额资金为由起诉亲信门首犯崔顺实，\n检方在起诉书中指出朴槿惠涉嫌共谋作案，在毫无一官半职的崔顺实索捐和获得政府机密文件的过程中扮演重要角色。\n但由于韩国宪法第84条规定现任总统享有刑事豁免权，检方无法起诉朴槿惠。";
        model.font = [UIFont systemFontOfSize:16];
        model.leftRightMargin = @(FIT6P(60));
        model.backgroudColor = HEX(0xefeff4);
        [self.dataModels addObject:model];
    }
    
    {
        VSTBKeyValueDataModel *model = [[VSTBKeyValueDataModel alloc] init];
        model.classString = @"VSKeyValueTBVC";
        model.identifier = @"com.cell.b";
        model.height = NUM_FLOAT(FIT6P(133));
        model.key = @"标题";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        [self.dataModels addObject:model];
    }
    
    {
        VSTBTitleDataModel *model = [[VSTBTitleDataModel alloc] init];
        model.classString = @"VSTitleTBVC";
        model.identifier = @"com.cell.aab";
        model.showGroupLine = YES;
        model.height = NUM_FLOAT(40);
        model.desc = @"功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总功能汇总";
        model.textAlignment = NSTextAlignmentLeft;
        
        model.leftRightMargin = @10;
        model.topMargin = @15;
        model.bottomMargin = @15;
        model.font = [UIFont systemFontOfSize:16];
        model.textColor = [UIColor blackColor];
        model.backgroudColor = HEX(0xefeff4);
        [self.dataModels addObject:model];
    }
    
    {
        VSTBButtonDataModel *model = [[VSTBButtonDataModel alloc] init];
        model.classString = @"VSButtonTBVC";
        model.identifier = @"com.cell.btn000";
        model.height = NUM_FLOAT(60);
        model.detailArrowIcon = NO;
        
        model.button_normal_color = HEX(0x09bb07);
        model.button_hightlight_color = [UIColor nv_colorRGBonvertToHSB:HEX(0x09bb07) withAlphaDelta:-0.2f];
        
        [self.dataModels addObject:model];
    }
}



@end
