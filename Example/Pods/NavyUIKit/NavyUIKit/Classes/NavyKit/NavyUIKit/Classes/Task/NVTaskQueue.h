//
//  NVTaskQueue.h
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVTask.h"



/**
 任务队列：执行队列顺序为先进先出
 */
@interface NVTaskQueue : NSObject

/**
 前期任务位置，从0开始，到队列中总任务数-1。
 */
@property (nonatomic, assign, readonly) NSUInteger interator;

/**
 整个任务队列完成后，触发回调。
 */
@property (nonatomic, copy) void(^taskQueueCallback)(NVTaskQueue* taskQueue, BOOL completed);

/**
 添加一个任务

 @param task 任务
 */
- (void) addTask:(NVTask*)task;

/**
 移除任务

 @param task 指定的任务
 */
- (void) removeTask:(NVTask*)task;

/**
 取消所有任务
 */
- (void) cancelAllTasks;

/**
 开始执行任务
 */
- (void) start;

/**
 下一个任务

 @return YES 执行下个任务成功 NO没有任务可执行了
 */
- (BOOL) next;

@end





