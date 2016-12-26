//
//  NVViewModelObserver.h
//  Navy
//
//  Created by Steven.Lin on 13/10/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"


/**
 观察者模式的实现，通过观察一个对象的属性变化，通过block回调，来处理。通过一个字典来存储观察的对象
 */
@interface NVViewModelObserver : NSObject
DEF_SINGLETON(NVViewModelObserver)


/**
 观察一个Model的属性变化

 @param object 对象
 @param keyPath 对象的属性的keypath
 @param eventBlock 事件回调
 */
- (void) attachObservedObject:(NSObject *)object
                   forKeyPath:(NSString *)keyPath
                        event:(void(^)(NSObject* object))eventBlock;

/**
 移除观察

 @param object 对象
 @param keyPath 属性
 */
- (void) detachObservedObject:(NSObject*)object
                   forKeyPath:(NSString*)keyPath;

@end
