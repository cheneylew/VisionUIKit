//
//  PAStorageOperationQueue.h
//  haofang
//
//  Created by Steven.Lin on 11/21/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVStorageOperation.h"
#import <UIKit/UIKit.h>


UIKIT_EXTERN NSString* const kStorageQueueMemory;
UIKIT_EXTERN NSString* const kStorageQueuePList;
UIKIT_EXTERN NSString* const kStorageQueueDisk;
UIKIT_EXTERN NSString* const kStorageQueueCoreData;
UIKIT_EXTERN NSString* const kStorageQueueKeyChain;



/*!
 @class
 @abstract      存储操作队列
 */
@interface NVStorageOperationQueue : NSObject

- (void)addOperation:(NVStorageOperation *)op;
- (void)addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait;
- (void)addOperationWithBlock:(void (^)(void))block;
- (void)cancelAllOperations;
@end
