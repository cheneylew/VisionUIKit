//
//  VSNormalDataConstructor.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSNormalDataConstructor.h"
#import "VSBaseTableViewCell.h"
#import <DJMacros/DJMacro.h>

@interface VSNormalDataConstructor ()

@end

@implementation VSNormalDataConstructor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModels = [NSMutableArray array];
        [self vs_addModels];
    }
    return self;
}

- (void)vs_addModels {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self vs_modelAtIndexPath:indexPath].identifier];
    [self configCellUI:cell indexPath:indexPath];
    if (cell == nil) {
        ASSERT_ALWAYS;
    }
    return cell;
}

- (void)configCellUI:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    VSTBBaseDataModel *model = [self vs_modelAtIndexPath:indexPath];
    VSBaseTableViewCell *vsCell = (VSBaseTableViewCell *)cell;
    vsCell.backgroundColor = model.backgroudColor;
    [vsCell setModel:model];
}

- (void)loadModels {
    WEAK_SELF;
    [self.dataModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[VSTBBaseDataModel class]]) {
            VSTBBaseDataModel *model = obj;
            if (!model.backgroudColor) {
                model.backgroudColor = [UIColor whiteColor];
            }
            if (!model.selectedBackgroudColor) {
                model.selectedBackgroudColor = HEX(0xf5f5f5);
            }
            if (!model.groupLineColor) {
                model.groupLineColor = HEX(0xd9d9d9);
            }
            if (!model.height) {
                model.height = NUM_FLOAT(FIT6P(135));
            }
            model.delegateController = weakself.delegateController;
            [self.TB registerClass:model.cellClass forCellReuseIdentifier:model.identifier];
        }
    }];
}

- (VSTBBaseDataModel *)vs_modelAtIndex:(NSUInteger)index {
    return [self.dataModels objectAtIndex:index];
}

- (NSIndexPath *)vs_indexPathOfModel:(VSTBBaseDataModel *)model {
    NSUInteger idx = [self.dataModels indexOfObject:model];
    return [NSIndexPath indexPathForRow:idx inSection:0];
}

- (VSTBBaseDataModel *)vs_modelAtIndexPath:(NSIndexPath *)indexPath {
    VSTBBaseDataModel *model = [self.dataModels objectAtIndex:indexPath.row];
    return model;
}

@end
