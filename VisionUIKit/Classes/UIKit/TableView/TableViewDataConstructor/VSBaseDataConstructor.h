//
//  VSBaseDataConstructor.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VSBaseTBVC.h"


@interface VSBaseDataConstructor : NSObject
<UITableViewDataSource>

@property (nonatomic, weak)             UITableView *TB;
@property (nonatomic, weak)             UIViewController *controller;
@property (nonatomic, strong, readonly) NSMutableArray *dataModels;

- (void)loadModels;

- (VSTBBaseDataModel *)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathOfModel:(VSTBBaseDataModel *)model;

#pragma mark - 子类重写

- (void)addModels;

@end
