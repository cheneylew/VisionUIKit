//
//  NVFundationSerialization.h
//  haofang
//
//  Created by Steven.Lin on 11/15/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSerializeProtocol.h"
#import "NVDataModel.h"



@interface NVFundationSerialization : NSObject <NVSerializeProtocol>

+ (NVDataModel*) serializeDictionary:(NSDictionary*)dictionary;
+ (NVListModel*) serializeArray:(NSArray*)array;

+ (NVDataModel*) serializeDictionary:(NSDictionary *)dictionary withClass:(Class)classInstance;
+ (NVListModel*) serializeArray:(NSArray *)array withClass:(Class)classInstance;

@end



@interface NVFundationDeserialization : NSObject <NVDeserializeProtocol>

@end



