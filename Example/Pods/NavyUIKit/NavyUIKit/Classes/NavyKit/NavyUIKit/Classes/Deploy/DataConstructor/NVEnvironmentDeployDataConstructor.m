//
//  NVEnvironmentDeployDataConstructor.m
//  Navy
//
//  Created by Jelly on 9/16/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVEnvironmentDeployDataConstructor.h"
#import "NVTagTableViewCell.h"
#import "NVTitleTableViewCell.h"
#import "NVButtonTableViewCell.h"
#import "NVTableViewNullCell.h"

#define kEnvCount 12

@implementation NVEnvironmentDeployDataConstructor


- (void) constructData {
    
    
    NVTitleDataModel* itemTitle = [[NVTitleDataModel alloc] init];
    itemTitle.cellClass         = [NVTitleTableViewCell class];
    itemTitle.cellType          = @"cell.type.title";
    itemTitle.cellHeight        = [NSNumber numberWithFloat:[NVTitleTableViewCell heightForCell]];
    
    itemTitle.title             = @"请选择配置环境并确定";
    [self.items addObject:itemTitle];
    
    
    
    NSString* arrayCellTitles[kEnvCount] = {
        @"AstraeaSae",
        @"开发环境1 [默认]",
        @"开发环境2 [主程主机]",
        @"测试环境1",
        @"测试环境2",
        @"测试环境3",
        @"测试环境4",
        @"测试环境6",
        @"测试环境7",
        @"测试环境8",
        @"准生产环境",
        @"生产环境",
    };
    
    NSString* arrayCellTypes[kEnvCount] = {
        @"cell.type.env.sae",
        @"cell.type.env.dev1",
        @"cell.type.env.dev2",
        @"cell.type.env.test1",
        @"cell.type.env.test2",
        @"cell.type.env.test3",
        @"cell.type.env.test4",
        @"cell.type.env.test6",
        @"cell.type.env.test7",
        @"cell.type.env.test8",
        @"cell.type.env.predis",
        @"cell.type.env.dis",
    };
    

    
    for (NSInteger i = 0; i < kEnvCount; i++) {
        NVTagDataModel* item        = [[NVTagDataModel alloc] init];
        item.cellClass              = [NVTagTableViewCell class];
        item.cellType               = arrayCellTypes[i];
        item.cellHeight             = [NSNumber numberWithFloat:[NVTagTableViewCell heightForCell]];
        
        item.title                  = arrayCellTitles[i];
        item.titleColor             = COLOR_HM_LIGHT_BLACK;
        item.selectionColor         = COLOR_HM_BLUE;
        item.selected               = [self.typeOfSelection isEqualToString:item.cellType];
        
        [self.items addObject:item];
    }
    
    
    NVDataModel* itemNull           = [[NVDataModel alloc] init];
    itemNull.cellClass              = [NVTableViewNullCell class];
    itemNull.cellType               = @"cell.type.null";
    itemNull.cellHeight             = [NSNumber numberWithFloat:20.0f];
    
    [self.items addObject:itemNull];
    
    
    
    NVButtonDataModel* itemBtn      = [[NVButtonDataModel alloc] init];
    itemBtn.cellClass               = [NVButtonTableViewCell class];
    itemBtn.cellType                = @"cell.type.button";
    itemBtn.cellHeight              = [NSNumber numberWithFloat:[NVButtonTableViewCell heightForCell]];
    
    itemBtn.title                   = @"确定";
    itemBtn.titleColor              = COLOR_DEFAULT_WHITE;
    itemBtn.backgroundColor         = COLOR_HM_BLUE;
    itemBtn.delegate                = self.viewControllerDelegate;
    
    [self.items addObject:itemBtn];
}


@end
