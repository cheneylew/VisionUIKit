//
//  VSAppServiceRouter.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/13.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//
//  *********************************************************  //
//  对MGJRouter进行了扩展，加入了WorkFlow，可定制任务流。
//  *********************************************************  //

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>
#import <MGJRouter/MGJRouter.h>
#import <Task/Task.h>

typedef void(^VSRouterComplation)(id result);

@interface VSRouterParams : NSObject

PP_STRING(URL)
PP_DICTIONARY(params)
PP_DICTIONARY(userinfo)
PP_COPY_BLOCK(VSRouterComplation, complation)

@property (nonatomic, weak) UIViewController *rootViewController;

@end

typedef void (^VSRouterHandler)(VSRouterParams *params);
typedef id   (^VSRouterSyncHandler)(VSRouterParams *params);


/**
 全局路由
 */
@interface VSRouter : NSObject

SINGLETON_ITF(VSRouter)

#pragma mark 异步任务

/**
 注册公共任务，如nAuth=Y或nLogin=Y等。
 公共任务可作为目标任务的参数传入。
 
 @param URLPattern 公共任务如：nLogin=Y或nAuth=Y
 @param handler 回调
 */
+ (void)registerCommonServiceWithURLPattern:(NSString *)URLPattern toHandler:(VSRouterHandler)handler;

/**
 注册普通任务，普通任务由普通任务+公共任务租车

 @param URLPattern 任务地址
 @param handler 回调
 */
+ (void)registerServiceWithURLPattern:(NSString *)URLPattern toHandler:(VSRouterHandler)handler;

/**
 任务能否打开

 @param URL 任务地址
 @return YES 可打开 NO 不可用
 */
+ (BOOL)canOpenURL:(NSString *)URL;


/**
 整个任务为顺序执行。
 任务逻辑：nLogin=Y&nAuth=Y 是公共的任务，可选作为参数传入，参数顺序为执行顺序，最后执行service/web这个任务。
 例如：hyhcrm://service/web?nLogin=Y&nAuth=Y
 有三个任务：
 1.登陆：nLogin=Y
 2.认证：nAuth=Y
 3.打开一个网页：service/web
 */
+ (void)openURL:(NSString *)URL;
+ (void)openURL:(NSString *)URL completion:(void (^)(id result))completion;
+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

#pragma mark 初始化任务

/**
 方法体里面写了几个demo，可以参考下
 */
- (void)initCommonTasks;    //初始化通用任务
- (void)initTasks;          //初始化一般任务

#pragma mark 注册同步任务
/**
 注册同步任务
 
 @param URLPattern <#URLPattern description#>
 @param handler <#handler description#>
 */
+ (void)sync_registerServiceWithURLPattern:(NSString *)URLPattern toHandler:(VSRouterSyncHandler)handler;
+ (BOOL)sync_canOpenURL:(NSString *)URL;
+ (id)  sync_openURL:(NSString *)URL;
+ (id)  sync_openURL:(NSString *)URL withUserInfo:(NSDictionary *) userInfo;

@end
