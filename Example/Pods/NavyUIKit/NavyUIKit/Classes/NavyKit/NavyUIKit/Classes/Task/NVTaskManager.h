//
//  NVTaskManager.h
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"
#import "NVTask.h"


@interface NVTaskManager : NSObject
DEF_SINGLETON(NVTaskManager)

- (void) addTask:(NVTask*)task name:(NSString*)name;
- (void) removeTask:(NVTask*)task name:(NSString*)name;
- (void) removeAllTaskWithName:(NSString*)name;

- (void) start:(NSString*)name finish:(void(^)(BOOL completed))block;

@end

