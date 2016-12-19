//
//  VSSerializedProtocol.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @protocol
 @abstract      序列化对象抽象类
 */
@protocol VSSerializedObjectProtocol <NSObject>

@optional
- (id) initWithDictionary:(NSDictionary*)dictionary;
- (id) initWithArray:(NSArray*)array;

+ (id) serializeWithDictionary:(NSDictionary*)dictionary;
+ (id) serializeWithArray:(NSArray*)array;

@end


/*!
 @protocol
 @abstract      反序列化对象抽象类
 */
@protocol VSDeserializedObjectProtocol <NSObject>

@optional
- (NSDictionary*) dictionaryValue;
- (NSArray*) arrayValue;

@end
