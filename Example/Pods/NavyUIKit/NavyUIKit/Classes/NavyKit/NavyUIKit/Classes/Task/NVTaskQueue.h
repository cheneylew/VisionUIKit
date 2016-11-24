//
//  NVTaskQueue.h
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVTask.h"



@interface NVTaskQueue : NSObject
@property (nonatomic, assign, readonly) NSUInteger interator;
@property (nonatomic, copy) void(^taskQueueCallback)(NVTaskQueue* taskQueue, BOOL completed);

- (void) addTask:(NVTask*)task;
- (void) removeTask:(NVTask*)task;
- (void) cancelAllTasks;

- (void) start;
- (BOOL) next;

@end





