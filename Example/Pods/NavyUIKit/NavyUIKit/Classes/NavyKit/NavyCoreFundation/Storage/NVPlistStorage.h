//
//  PAPlistStorage.h
//  haofang
//
//  Created by Steven.Lin on 11/18/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVStorageProtocol.h"



/*!
 @class
 @abstract      Plist存储类
 */
@interface NVPlistStorage : NSObject <NVFundationStorageProtocol>
@property (nonatomic, copy, readonly) NSString* fileName;
- (id) initWithFileName:(NSString*)fileName;
- (void) save;
@end



@interface PACoreDataStorage : NSObject <NVFundationStorageProtocol>

@end




@interface PADiskStorage : NSObject <NVFundationStorageProtocol>

@end


