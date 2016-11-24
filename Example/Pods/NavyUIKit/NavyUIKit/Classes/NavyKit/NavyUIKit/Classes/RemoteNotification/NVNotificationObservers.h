//
//  NVNotificationObservers.h
//  Navy
//
//  Created by Steven.Lin on 16/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"
#import "NVNotifyObservedObject.h"


@interface NVNotificationObservers : NSObject
DEF_SINGLETON(NVNotificationObservers)

@property (nonatomic, strong, readonly) NSString* serviceTag;
@property (nonatomic, strong, readonly) NSString* paramTag;

- (void) setServiceTag:(NSString*)serviceTag;
- (void) setParamTag:(NSString*)paramTag;

- (void) addObserverName:(NSString*)name
        notificationName:(NSString*)notificationName
                  invoke:(void(^)(NSString* name, NSDictionary* parameters))block;

- (NVNotifyObservedObject*) observedObjectForNotification:(NSDictionary *)notification;

@end


