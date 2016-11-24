//
//  NVSerializedObjectProtocol.h
//  haofang
//
//  Created by Steven.Lin on 11/15/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @protocol
 @abstract      序列化对象抽象类
 */
@protocol NVSerializedObjectProtocol <NSObject>

@end


/*!
 @protocol
 @abstract      反序列化对象抽象类
 */
@protocol NVDeserializedObjectProtocol <NSObject>

@end


/*!
 @protocol
 @abstract      序列化Fundation对象抽象类
 */
@protocol NVFundationSerializedObjectProtocol <NVSerializedObjectProtocol>

@optional
- (id) initWithDictionary:(NSDictionary*)dictionary;
- (id) initWithArray:(NSArray*)array;

+ (id) serializeWithDictionary:(NSDictionary*)dictionary;
+ (id) serializeWithArray:(NSArray*)array;
@end


/*!
 @protocol
 @abstract      反序列化Fundation对象抽象类
 */
@protocol NVFundationDeserializedObjectProtocol <NVDeserializedObjectProtocol>

@optional
- (NSDictionary*) dictionaryValue;
- (NSArray*) arrayValue;
@end




