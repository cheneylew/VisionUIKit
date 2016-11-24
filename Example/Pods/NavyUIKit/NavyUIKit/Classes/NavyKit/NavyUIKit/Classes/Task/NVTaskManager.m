//
//  NVTaskManager.m
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVTaskManager.h"
#import "NVTaskQueue.h"


@interface NVTaskManager ()
@property (nonatomic, strong) NSMutableDictionary* dictionary;
@property (nonatomic, copy) void(^taskQueueCallback)(NVTaskQueue* taskQueue, BOOL completed);
@property (nonatomic, copy) void(^finishBlock)(BOOL completed);
@end



@implementation NVTaskManager
IMP_SINGLETON


- (NSMutableDictionary*) dictionary {
    if (_dictionary == nil) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _dictionary;
}

- (void(^)(NVTaskQueue* taskQueue, BOOL completed))taskQueueCallback {
    return ^(NVTaskQueue* taskQueue, BOOL completed) {
        if (self.finishBlock) {
            [taskQueue cancelAllTasks];
            self.finishBlock(completed);
        }
    };
}


- (void) addTask:(NVTask *)task name:(NSString *)name {
    
    NVTaskQueue* taskQueue  = [self.dictionary objectForKey:name];
    if (![taskQueue isKindOfClass:[NVTaskQueue class]]) {
        taskQueue                   = [[NVTaskQueue alloc] init];
        taskQueue.taskQueueCallback = self.taskQueueCallback;
        [self.dictionary setObject:taskQueue forKey:name];
    }
        
    [taskQueue addTask:task];
}

- (void) removeAllTaskWithName:(NSString *)name {
    NVTaskQueue* taskQueue  = [self.dictionary objectForKey:name];
    if ([taskQueue isKindOfClass:[NVTaskQueue class]]) {
        [self.dictionary removeObjectForKey:name];
    }
}

- (void) removeTask:(NVTask *)task name:(NSString *)name {
    NVTaskQueue* taskQueue  = [self.dictionary objectForKey:name];
    if ([taskQueue isKindOfClass:[NVTaskQueue class]]) {
        [taskQueue removeTask:task];
    }
}


- (void) start:(NSString *)name finish:(void (^)(BOOL))block {
    
    self.finishBlock            = block;
    
    NVTaskQueue* taskQueue      = [self.dictionary objectForKey:name];
    
    [taskQueue start];
    [taskQueue next];
}

@end



