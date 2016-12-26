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


/**
 添加任务到指定的队列中，每个队列可用一个字符串来指定

 @param task    任务
 @param queueID 队列ID字符串，自定义
 */
- (void) addTask:(NVTask*)task name:(NSString*)queueID;

/**
 移除指定队列中的任务

 @param task    任务
 @param queueID 队列ID
 */
- (void) removeTask:(NVTask*)task name:(NSString*)queueID;

/**
 移除一组任务队列

 @param queueID 任务队列ID
 */
- (void) removeAllTaskWithName:(NSString*)queueID;


/**
 开始执行指定的任务队列

 @param queueID 队列ID
 @param block   完成后的回调
 */
- (void) start:(NSString*)queueID
        finish:(void(^)(BOOL completed))block;

@end

