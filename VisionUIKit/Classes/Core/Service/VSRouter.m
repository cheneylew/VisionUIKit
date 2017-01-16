//
//  VSAppServiceRouter.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/13.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSRouter.h"
#import <Task/Task.h>
#import <KKCategories/KKCategories.h>

@implementation VSRouterParams

@end

@interface VSRouterTask : NSObject

PP_STRONG(NSString, URL)
PP_COPY_BLOCK(VSRouterSyncHandler, taskBlock)

@end

@implementation VSRouterTask

@end

@interface VSRouter ()
<TSKWorkflowDelegate>

PP_STRONG(NSMutableArray<TSKWorkflow *>, workflows)
PP_STRONG(NSMutableArray<VSRouterTask *>, syncTasks);

@end


@implementation VSRouter

SINGLETON_IMPL(VSRouter)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _workflows = [NSMutableArray new];
        _syncTasks = [NSMutableArray new];
    }
    return self;
}

- (void)workflowDidFinish:(TSKWorkflow *)workflow {
    @synchronized (self) {
        [self.workflows removeObject:workflow];
    }
}

- (void)workflow:(TSKWorkflow *)workflow taskDidCancel:(TSKTask *)task {
    @synchronized (self) {
        [self.workflows removeObject:workflow];
    }
}

- (void)workflow:(TSKWorkflow *)workflow task:(TSKTask *)task didFailWithError:(NSError *)error {
    @synchronized (self) {
        [self.workflows removeObject:workflow];
    }
}

#pragma mark - 公共通用方法

+ (NSString *) siteOfURL:(NSString *) URL{
    URL = [URL jk_urlDecode];
    NSURL *tmpURL = [NSURL URLWithString:[URL jk_urlEncodedOnlyChinese]];
    NSString* paramsString = tmpURL.query;
    NSArray<NSString *>* params = [paramsString componentsSeparatedByString:@"?"];
    if (params.count == 2) {
        return params[0];
    } else
        return nil;
}

+ (NSArray *) paramsArrayOfURL:(NSString *) URL{
    URL = [URL jk_urlDecode];
    NSURL *tmpURL = [NSURL URLWithString:[URL jk_urlEncodedOnlyChinese]];
    NSString* paramsString = tmpURL.query;
    NSArray<NSString *>* params = [paramsString componentsSeparatedByString:@"&"];
    return params;
}

+ (NSDictionary *) paramsOfURL:(NSString *) URL {
    NSMutableDictionary* result = [NSMutableDictionary new];
    [[self paramsArrayOfURL:URL] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            NSArray *arr = [obj componentsSeparatedByString:@"="];
            if (arr.count == 2) {
                [result setObject:[arr[1] jk_urlDecodedOnlyChinese] forKey:[arr[0] jk_urlDecodedOnlyChinese]];
            }
        }
    }];
    return result;
}

#pragma mark - 静态方法

+ (void)registerCommonServiceWithURLPattern:(NSString *)URLPattern toHandler:(VSRouterHandler)handler
{
    [MGJRouter registerURLPattern:URLPattern toHandler:^(NSDictionary *routerParameters) {
        VSRouterParams *params = [VSRouterParams new];
        params.URL = routerParameters[MGJRouterParameterURL];
        params.complation = routerParameters[MGJRouterParameterCompletion];
        
        NSMutableDictionary *routerParams = [[NSMutableDictionary alloc] initWithDictionary:routerParameters];
        [routerParams removeObjectForKey:MGJRouterParameterURL];
        [routerParams removeObjectForKey:MGJRouterParameterCompletion];
        params.params = routerParams;
        handler(params);
    }];
}

+ (void)registerServiceWithURLPattern:(NSString *)URLPattern toHandler:(VSRouterHandler)handler
{
    [MGJRouter registerURLPattern:URLPattern toHandler:^(NSDictionary *routerParameters) {
        VSRouterParams *params = [VSRouterParams new];
        params.URL = routerParameters[MGJRouterParameterURL];
        params.complation = routerParameters[MGJRouterParameterCompletion];
        
        NSMutableDictionary *routerParams = [[NSMutableDictionary alloc] initWithDictionary:routerParameters];
        [routerParams removeObjectForKey:MGJRouterParameterURL];
        [routerParams removeObjectForKey:MGJRouterParameterCompletion];
        params.params = routerParams;
        handler(params);
    }];
}

+ (BOOL)canOpenURL:(NSString *)URL {
    return [MGJRouter canOpenURL:URL];
}

+ (void)openURL:(NSString *)URL {
    [self openURL:URL withUserInfo:nil completion:nil];
}

+ (void)openURL:(NSString *)URL completion:(void (^)(id))completion {
    [self openURL:URL withUserInfo:nil completion:completion];
}

+ (void)openURL:(NSString *)URL
   withUserInfo:(NSDictionary *)userInfo
     completion:(void (^)(id result))completion {
    NSArray* params = [self paramsArrayOfURL:URL];
    
    TSKWorkflow *workflow = [[TSKWorkflow alloc] initWithName:[NSString stringWithFormat:@"%ld",(unsigned long)[VSRouter sharedInstance].workflows.count]];
    workflow.delegate = [VSRouter sharedInstance];
    
    NSMutableArray *preTasks = [NSMutableArray new];
    WEAK(preTasks);
    [params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TSKBlockTask *task = [[TSKBlockTask alloc] initWithName:obj block:^(TSKTask *task) {
            WEAK(task);
            dispatch_async(dispatch_get_main_queue(), ^{
                [MGJRouter openURL:obj withUserInfo:nil completion:^(id result) {
                    [weaktask finishWithResult:result];
                }];
            });
        }];
        [workflow addTask:task prerequisites:preTasks.lastObject, nil];
        [weakpreTasks addObject:task];
    }];
    
    TSKBlockTask *targetTask = [[TSKBlockTask alloc] initWithName:URL block:^(TSKTask *task) {
        WEAK(task);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MGJRouter openURL:URL withUserInfo:userInfo completion:^(id result) {
                completion(result);
                [weaktask finishWithResult:result];
            }];
        });
    }];
    
    [workflow addTask:targetTask prerequisites:preTasks.lastObject, nil];
    [workflow start];
    
    [[VSRouter sharedInstance].workflows addObject:workflow];
}

- (void)initCommonTasks {
    [VSRouter registerCommonServiceWithURLPattern:@"nLogin=Y" toHandler:^(VSRouterParams *params) {
        NSLog(@"完成登陆");
        if (params.complation) {
            params.complation(@"abc");
        };
    }];
    
    [VSRouter registerCommonServiceWithURLPattern:@"nAuth=Y" toHandler:^(VSRouterParams *params) {
        NSLog(@"完成认证");
        if (params.complation) {
            params.complation(@"abc");
        }
    }];
    
    [VSRouter registerServiceWithURLPattern:@"hyhcrm://service/web" toHandler:^(VSRouterParams *params) {
        NSLog(@"完成访问网页");
        if (params.complation) {
            params.complation(@"abc");
        }
    }];
}
- (void)initTasks {
    [VSRouter openURL:@"hyhcrm://service/web?nAuth=Y&nLogin=Y" withUserInfo:nil completion:^(id result) {
        NSLog(@"整个流程完成");
    }];
}

#pragma mark 同步任务
+ (void)sync_registerServiceWithURLPattern:(NSString *)URLPattern toHandler:(VSRouterSyncHandler)handler {
    VSRouterTask *rtTask = [VSRouterTask new];
    rtTask.URL = URLPattern;
    rtTask.taskBlock = handler;
    
    if (![self sync_canOpenURL:URLPattern]) {
        VSRouter *router = [VSRouter sharedInstance];
        [router.syncTasks addObject:rtTask];
    }
}

+ (id)sync_openURL:(NSString *)URL {
    return [self sync_openURL:URL withUserInfo:nil];
}

+ (id)sync_openURL:(NSString *)URL withUserInfo:(NSDictionary *) userInfo {
    URL = [URL jk_urlDecode];
    if (![self sync_canOpenURL:URL]) {
        return nil;
    }
    
    VSRouter *router = [VSRouter sharedInstance];
    
    __block VSRouterTask *task = nil;
    [router.syncTasks enumerateObjectsUsingBlock:^(VSRouterTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([VSRouter siteOfURL:obj.URL] == [VSRouter siteOfURL:URL]) {
            task = obj;
        }
    }];
    if (task) {
        id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
        UIWindow *window = [delegate performSelector:@selector(window)];
        
        VSRouterParams *params = [VSRouterParams new];
        params.params = [self paramsOfURL:URL];
        params.URL = URL;
        params.userinfo = userInfo;
        params.rootViewController = window ? window.rootViewController : nil;
        return task.taskBlock(params);
    }
    return nil;
}

+ (BOOL)sync_canOpenURL:(NSString *)URL {
    __block BOOL ok = NO;
    [[VSRouter sharedInstance].syncTasks enumerateObjectsUsingBlock:^(VSRouterTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([VSRouter siteOfURL:obj.URL] == [VSRouter siteOfURL:URL]) {
            ok = YES;
        }
    }];
    
    return ok;
}

@end
