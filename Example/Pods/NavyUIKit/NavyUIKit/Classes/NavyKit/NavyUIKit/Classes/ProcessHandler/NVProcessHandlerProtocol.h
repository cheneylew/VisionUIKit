//
//  NVProcessHandlerProtocol.h
//  Navy
//
//  Created by Steven.Lin on 5/3/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol NVProcessHandlerProtocol <NSObject>
- (void) execute:(id)data
         keyName:(NSString*)keyName
         success:(void(^)(id, NSString* error))successBlock
         failure:(void(^)(id, NSString* error))failureBlock;

@end
