//
//  VSTBConstructor.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VSTBDataModel.h"

@interface VSTBConstructor : NSObject
<UITableViewDataSource>

@property (nonatomic, weak)             UITableView *TB;
@property (nonatomic, strong, readonly) NSMutableArray *dataModels;

- (void)loadModels;

- (VSTBDataModel *)modelAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - 子类重写

- (void)addModels;

@end
