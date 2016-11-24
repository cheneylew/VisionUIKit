//
//  PAStorageOperation.h
//  haofang
//
//  Created by Steven.Lin on 11/21/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSerializedObjectProtocol.h"
#import "NVDataModel.h"



typedef NS_ENUM(NSUInteger, NVStorageOperationPolicy) {
    NVStorageOperationPolicyMemory,
    NVStorageOperationPolicyPList,
    NVStorageOperationPolicyDisk,
    NVStorageOperationPolicyCoreData,
    NVStorageOperationPolicyKeyChain,
};

/*!
 @class
 @abstract      存储操作类
 */
@interface NVStorageOperation : NSOperation

/*!
 @property
 @abstract      被存储操作的数据模型对象。
                此对象须遵循PAFundationDeserializedObjectProtocol协议
 */
@property (nonatomic, strong) NVDataModel<NVFundationDeserializedObjectProtocol>* object;

@property (nonatomic, strong) NSString* keyName;

/*!
 @property
 @abstract      存储策略
 */
@property (nonatomic, assign) NVStorageOperationPolicy policy;

@end


/*!
 @class
 @abstract      存储读操作类
 */
@interface NVStorageReadOperation : NVStorageOperation

/*!
 @property
 @abstract      读操作回调Block
 */
@property (nonatomic, copy) void (^readBlock)(id);

@end


/*!
 @class
 @abstract      存储写操作类
 */
@interface NVStorageWriteOperation : NVStorageOperation

/*!
 @property
 @abstract      写操作回调Block
 */
@property (nonatomic, copy) void (^writeBlock)(void);

@end



@interface NVStorageDeleteOperation : NVStorageOperation
/*!
 @property
 @abstract      删除操作回调Block
 */
@property (nonatomic, copy) void (^deleteBlock)(BOOL);

@end

