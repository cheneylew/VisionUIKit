//
//  PAStorageManager.h
//  haofang
//
//  Created by Steven.Lin on 11/18/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVStorageOperationQueue.h"
#import "NVStorageOperation.h"
#import "NVSingleton.h"


/*!
 @class
 @abstract      存储管理类
 */
@interface NVStorageManager : NSObject

DEF_SINGLETON(NVStorageManager)

@property (nonatomic, strong) NVStorageOperationQueue* operationQueue;

- (void) readObjectWithKeyName:(NSString*)keyName block:(void(^)(id object))block;

@end




/*!
 @class
 @abstract      存储管理类 (迁移扩展)
 */
@interface NVStorageManager (Transfer)


/**
 *	@brief	<#Description#>
 *
 *	@param 	keyName 	<#keyName description#>
 *	@param 	fromPolicy 	<#fromPolicy description#>
 *	@param 	toPolicy 	<#toPolicy description#>
 *
 *	@return	<#return value description#>
 */
- (void) transferWithKeyName:(NSString*)keyName
                        from:(NVStorageOperationPolicy)fromPolicy
                          to:(NVStorageOperationPolicy)toPolicy
                   completed:(void(^)(BOOL))completed;

/**
 *	@brief	<#Description#>
 *
 *	@param 	keyName 	<#keyName description#>
 *	@param 	fromPolicy 	<#fromPolicy description#>
 *	@param 	toPolicy 	<#toPolicy description#>
 *	@param 	overwrite 	<#overwrite description#>
 *	@param 	reserved 	<#reserve description#>
 *
 *	@return	<#return value description#>
 */
- (void) transferWithKeyName:(NSString*)keyName
                        from:(NVStorageOperationPolicy)fromPolicy
                          to:(NVStorageOperationPolicy)toPolicy
                   overwrite:(BOOL)overwrite
                    reserved:(BOOL)reserved
                   completed:(void(^)(BOOL))completed;


@end



