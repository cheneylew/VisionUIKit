//
//  VSTBConstructor.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBConstructor.h"
#import "VSTBDataModel.h"
#import "VSTBTableViewCell.h"
#import <DJMacros/DJMacro.h>

@interface VSTBConstructor ()

@end

@implementation VSTBConstructor

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataModels = [NSMutableArray array];
        [self addModels];
    }
    return self;
}

- (void)addModels {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self modelAtIndexPath:indexPath].identifier];
    [self configCellUI:cell indexPath:indexPath];
    return cell;
}

- (void)configCellUI:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    VSTBDataModel *model = [self modelAtIndexPath:indexPath];
    VSTBTableViewCell *vsCell = (VSTBTableViewCell *)cell;
    vsCell.backgroundColor = model.backgroudColor;
    vsCell.cellModel = model;
}

- (VSTBDataModel *)modelAtIndexPath:(NSIndexPath *)indexPath {
    VSTBDataModel *model = [self.dataModels objectAtIndex:indexPath.row];
    return model;
}

- (void)loadModels {
    
    [self.dataModels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[VSTBDataModel class]]) {
            VSTBDataModel *model = obj;
            if (!model.backgroudColor) {
                model.backgroudColor = [UIColor whiteColor];
            }
            if (!model.selectedBackgroudColor) {
                model.selectedBackgroudColor = HEX(0xf5f5f5);
            }
            if (!model.groupLineColor) {
                model.groupLineColor = HEX(0xececec);
            }
            if (!model.height) {
                model.height = NUM_FLOAT(FIT6P(135));
            }
            [self.TB registerClass:NSClassFromString(model.classString) forCellReuseIdentifier:model.identifier];
        }
    }];
}

@end
