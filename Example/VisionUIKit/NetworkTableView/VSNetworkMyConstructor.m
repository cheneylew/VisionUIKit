//
//  VSNetworkMyConstructor.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/4.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSNetworkMyConstructor.h"
#import "VSTitleDetailTableViewCell.h"
#import "VSTitleFieldTableViewCell.h"
#import <DJMacros/DJMacro.h>
#import <DJNetworking/DJNetworking.h>
#import "VSNetUser.h"
#import <MJExtension/MJExtension.h>

@implementation VSNetworkMyConstructor

- (void)vs_loadData {
    [DJCenter setupConfig:^(DJConfig * _Nonnull config) {
        config.callbackQueue = dispatch_get_main_queue();
    }];
    [DJCenter sendRequest:^(DJRequest * _Nonnull request) {
        request.server = @"http://localhost/ci/app/moc";
    } onSuccess:^(id  _Nullable responseObject) {
        NSArray *users = [VSNetUser mj_objectArrayWithKeyValuesArray:responseObject];
        self.list = [[VSListModel alloc] initWithModels:users];
        [self vs_callDelegateSuccess:users];
    } onFailure:^(NSError * _Nullable error) {
        [self vs_callDelegateError:error];
    } onFinished:^(id  _Nullable responseObject, NSError * _Nullable error) {
        //
    }];
}

- (void)vs_loadMore {
    
}

- (void)vs_addModels {
    if (self.list.count) {
        [self.dataModels removeAllObjects];
        [self.list.items enumerateObjectsUsingBlock:^(VSNetUser *user, NSUInteger idx, BOOL * _Nonnull stop) {
            VSTBTitleDetailDataModel *model = [[VSTBTitleDetailDataModel alloc] init];
            model.cellClass = [VSTitleDetailTableViewCell class];
            model.identifier = @"com.cell.a";
            model.showGroupLine = YES;
            model.height = NUM_FLOAT(FIT6P(133));
            model.key = user.name;
            model.detailArrowIcon = YES;
            model.value = user.sex;
            model.selectedStyle = VSTBCellSelectedStyleCustom;
            model.showTopLine = YES;
            model.showBottomLine = YES;
            [self.dataModels addObject:model];
        }];
        return;
    }
    {
        VSTBTitleDetailDataModel *model = [[VSTBTitleDetailDataModel alloc] init];
        model.cellClass = [VSTitleDetailTableViewCell class];
        model.identifier = @"com.cell.a";
        model.showGroupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.key = @"标题1";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        model.selectedStyle = VSTBCellSelectedStyleCustom;
        model.showTopLine = YES;
        model.showBottomLine = YES;
        [self.dataModels addObject:model];
    }
    {
        VSTBTitleDetailDataModel *model = [[VSTBTitleDetailDataModel alloc] init];
        model.cellClass = [VSTitleDetailTableViewCell class];
        model.identifier = @"com.cell.b";
        model.showGroupLine = YES;
        model.height = NUM_FLOAT(FIT6P(133));
        model.key = @"标题2";
        model.detailArrowIcon = YES;
        model.value = @"2.0 元";
        model.selectedStyle = VSTBCellSelectedStyleCustom;
        model.showTopLine = YES;
        model.showBottomLine = YES;
        [self.dataModels addObject:model];
    }
    
    {
        VSTBTitleFieldDataModel *modelA = [[VSTBTitleFieldDataModel alloc] init];
        modelA.cellClass = [VSTitleFieldTableViewCell class];
        modelA.identifier = @"com.cell.field1";
        modelA.showGroupLine = YES;
        modelA.height = NUM_FLOAT(FIT6P(133));
        modelA.key = @"数据绑定-被绑定对象";
        modelA.detailArrowIcon = YES;
        modelA.value = @"这里将改变";
        modelA.fieldColor = [UIColor redColor];
        modelA.fieldFont = [UIFont systemFontOfSize:18];
        [self.dataModels addObject:modelA];
    }
}

@end
