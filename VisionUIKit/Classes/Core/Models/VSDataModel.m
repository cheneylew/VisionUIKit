//
//  VSDataModel.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/5.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSDataModel.h"

@implementation VSDataModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initModel];
    }
    return self;
}

- (void)initModel {
    
}

@end


@implementation VSListModel

- (void)initModel {
    [super initModel];
}

- (NSMutableArray *)items {
    if (_items == nil) {
        _items = [NSMutableArray new];
    }
    
    return _items;
}

@end

