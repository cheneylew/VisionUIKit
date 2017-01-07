//
//  VSDataModel.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/5.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSSerializedProtocol.h"

@interface VSDataModel : NSObject

- (void)initModel;

@end

@interface VSListModel : VSDataModel
<VSSerializedObjectProtocol>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign, readonly) NSInteger count;
@property (nonatomic, assign) NSInteger total;

- (instancetype)initWithModels:(NSArray *)models;

@end
