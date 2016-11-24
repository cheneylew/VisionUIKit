//
//  NVSerializeProtocol.h
//  haofang
//
//  Created by Steven.Lin on 11/15/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @protocol
 @abstract      序列化抽象类
 */
@protocol NVSerializeProtocol <NSObject>

/*!
 @function
 @abstract      序列化方法
 */
- (id) serialize:(id)object;
@end



/*!
 @protocol
 @abstract      反序列化抽象类
 */
@protocol NVDeserializeProtocol <NSObject>

/*!
 @function
 @abstract      反序列化方法
 */
- (id) deserialize:(id)object;
@end