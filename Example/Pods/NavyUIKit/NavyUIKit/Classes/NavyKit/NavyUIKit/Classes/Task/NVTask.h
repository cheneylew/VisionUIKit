//
//  NVTask.h
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVTaskObjectProtocol.h"


/**
 任务实例
 */
@interface NVTask : NSObject

/**
 对象实现NVTaskObjectProtocol协议，即可作为一个Task
 */
@property (nonatomic, strong) id<NVTaskObjectProtocol> object;

/**
 Task需要传递的参数
 */
@property (nonatomic, strong) NSDictionary* userInfo;

/**
 Task任务完成后的回调
 */
@property (nonatomic, copy) void(^callback)(BOOL completed);

/**
 执行任务
 */
- (void) execute;
@end
