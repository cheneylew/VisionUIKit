//
//  VSNormalDataConstructor.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VSBaseTableViewCell.h"


@interface VSNormalDataConstructor : NSObject
<UITableViewDataSource>

@property (nonatomic, weak)             UITableView *TB;
@property (nonatomic, weak)             UIViewController *delegateController;
@property (nonatomic, strong, readonly) NSMutableArray *dataModels;


/**
 给TableView注册所有Model对应的Cell
 */
- (void)loadModels;

#pragma mark - 子类重写

- (void)vs_addModels;

#pragma mark 辅助查询
- (VSTBBaseDataModel *)vs_modelAtIndex:(NSUInteger)index;
- (VSTBBaseDataModel *)vs_modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)vs_indexPathOfModel:(VSTBBaseDataModel *)model;

@end
