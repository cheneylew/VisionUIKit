//
//  NVReactor.h
//  Navy
//
//  Created by Steven.Lin on 19/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVDataModel.h"


@interface NVReactor : NSObject

- (void) registerObservedObject:(NVDataModel*)dataModel
                 objectIdentity:(NSString*)identity
                     forKeyPath:(NSString*)keyPath
                          block:(void (^)(NSObject *))eventBlock;

- (void) unregisterObservedObjectForIdentity:(NSString*)identity;

- (void) unregisterAllObservedObjects;

@end
