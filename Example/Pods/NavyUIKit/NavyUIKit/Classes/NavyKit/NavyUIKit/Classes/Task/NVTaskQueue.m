//
//  NVTaskQueue.m
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVTaskQueue.h"
#import <DJMacros/DJMacro.h>

@interface NVTaskQueue ()
@property (nonatomic, strong) NSMutableArray* arrayTasks;
@property (nonatomic, copy) void(^taskCallback)(BOOL completed);
@end


@implementation NVTaskQueue
@synthesize interator = _interator;

- (void)dealloc
{
    DLog(@"NVTaskQueue Dealloc");
}

- (NSMutableArray*) arrayTasks {
    if (_arrayTasks == nil) {
        _arrayTasks = [[NSMutableArray alloc] init];
    }
    
    return _arrayTasks;
}

- (void(^)(BOOL completed)) taskCallback {
    return ^(BOOL completed) {
        if (completed) {
            [self next];
        }
    };
}


- (void) addTask:(NVTask *)task {
    [self.arrayTasks addObject:task];
    task.callback   = self.taskCallback;
}

- (void) removeTask:(NVTask *)task {
    [self.arrayTasks removeObject:task];
}

- (void) cancelAllTasks {
    [self.arrayTasks removeAllObjects];
}

- (void) start {
    _interator = 0;
    
}

- (BOOL) next {
    if (_interator < [self.arrayTasks count]) {
        NVTask* task = [self.arrayTasks objectAtIndex:_interator++];
        [task execute];
        
        return YES;
    }
    
    if (self.taskQueueCallback) {
        self.taskQueueCallback(self, YES);
    }
    
    return NO;
}

@end
