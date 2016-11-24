//
//  NVViewModelObserver.h
//  Navy
//
//  Created by Steven.Lin on 13/10/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"


@interface NVViewModelObserver : NSObject
DEF_SINGLETON(NVViewModelObserver)

- (void) attachObservedObject:(NSObject *)object
                   forKeyPath:(NSString *)keyPath
                        event:(void(^)(NSObject* object))eventBlock;

- (void) detachObservedObject:(NSObject*)object
                   forKeyPath:(NSString*)keyPath;

@end
