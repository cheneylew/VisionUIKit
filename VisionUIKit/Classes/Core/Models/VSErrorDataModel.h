//
//  VSErrorDataModel.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSDataModel.h"
#import "VSSerializedProtocol.h"

typedef enum : NSUInteger {
    VSErrorType_ResponseSystemError,        //网络错误 如服务器500/404等系统返回的错误
    VSErrorType_ResponseValidJSON,          //响应数据 无法转换为JSON
} VSErrorType;

@interface VSErrorDataModel : VSDataModel

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSError* error;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, assign) VSErrorType errorType;

+ (VSErrorDataModel *)InitErrorType:(VSErrorType)type;
- (instancetype)initWithErrorType:(VSErrorType)type;

@end


@interface VSSuccessDataModel : VSDataModel

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, assign) BOOL result;

@end
