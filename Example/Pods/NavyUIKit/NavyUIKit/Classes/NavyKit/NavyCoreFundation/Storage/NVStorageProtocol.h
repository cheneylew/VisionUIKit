//
//  NVStorageProtocol.h
//  haofang
//
//  Created by Steven.Lin on 11/18/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @protocol
 @abstract      存储抽象类。
                定义最抽象的存储函数
 */
@protocol NVStorageProtocol <NSObject>

@optional
/*!
 @function
 @abstract      读数据
 */
- (void) read;

/*!
 @function
 @abstract      写数据
 */
- (void) write;

@end


/*!
 @protocol
 @abstract      存储抽象类。
                定义最基本的存储函数
 */
@protocol NVFundationStorageProtocol <NVStorageProtocol>

- (id) readObjectForKey:(NSString*)key;
- (void) writeObject:(id)object forKey:(NSString*)key;

- (void) deleteObject:(id)object forKey:(NSString*)key;

@optional
- (id) readObject;
- (void) writeObject:(id)object;

@end