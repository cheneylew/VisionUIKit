//
//  VSErrorDataModel.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSErrorDataModel.h"

@implementation VSErrorDataModel

- (instancetype)initWithErrorType:(VSErrorType)type
{
    self = [super init];
    if (self) {
        self.errorType = type;
    }
    return self;
}

+ (VSErrorDataModel *)InitErrorType:(VSErrorType)type {
    return [[VSErrorDataModel alloc] initWithErrorType:type];
}

- (NSString *)description {
    return self.error.description;
}

@end
