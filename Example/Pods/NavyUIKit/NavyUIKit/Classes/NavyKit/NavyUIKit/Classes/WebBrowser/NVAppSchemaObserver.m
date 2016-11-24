//
//  NVAppSchemaObserver.m
//  Navy
//
//  Created by Steven.Lin on 15/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVAppSchemaObserver.h"
#import "NSDictionary+Category.h"
#import "NSString+Category.h"
#import "NVTaskManager.h"
#import "NavyUIKit.h"


@interface NVAppSchemaObserver ()
@property (nonatomic, strong) NSMutableDictionary* dictObserver;
@property (nonatomic, strong) NSMutableDictionary* dictPublicParams;
@end


@implementation NVAppSchemaObserver
IMP_SINGLETON

- (id) init {
    self = [super init];
    if (self) {

        self.dictObserver           = [NSMutableDictionary dictionary];
        self.dictPublicParams       = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (void) setAppSchema:(NSString *)appSchema {
    _appSchema = appSchema;
}

- (BOOL) hasAppSchema:(NSString *)urlSchema {
    return [_appSchema isEqualToString:urlSchema];
}



- (void) addPublicParamName:(NSString *)paramName
                     invoke:(void (^)(NSString *, NSString *, UIViewController *, void(^callback)(BOOL completed)))block {
    
    NVAsPublicParamObject* object   = [[NVAsPublicParamObject alloc] init];
    object.name                     = paramName;
    object.invokeBlock              = block;
    
    [self.dictPublicParams setObject:object forKey:paramName];
}



- (void) addObserverName:(NSString *)name
             serviceName:(NSString *)serviceName
                  invoke:(id (^)(NSString *, NSDictionary *, UIViewController *))block {
    
    NVAsObservedObject* object      = [[NVAsObservedObject alloc] init];
    object.name                     = name;
    object.serviceName              = serviceName;
    object.invokeBlock              = block;
    
    [self.dictObserver setObject:object forKey:serviceName];
}



- (void) addObserverName:(NSString *)name
                 webName:(NSString *)webName
                  invoke:(void (^)(NSString *, NSDictionary *, UIViewController *))block {
    
}

- (NVAsObservedObject*) observedObjectForServiceName:(NSString *)serviceName {
    return [self.dictObserver nvObjectForKey:serviceName];
}

- (NVAsPublicParamObject*) publicParamObjectForParamName:(NSString *)paramName {
    return [self.dictPublicParams nvObjectForKey:paramName];
}

- (NSArray*) hasPublicParamExisted:(NSArray *)paramNames {
    if ([paramNames count] > 0) {
        
        NSMutableArray* result  = [NSMutableArray array];
        
        [paramNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary* keyValue  = (NSDictionary*)obj;
            NSString* paramName     = [[keyValue allKeys] objectAtIndex:0];
//            NSString* paramName     = (NSString*)obj;
            
            [self.dictPublicParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSString* name                  = (NSString*)key;
                NVAsPublicParamObject* object   = (NVAsPublicParamObject*)obj;
                
                if ([paramName isEqualToString:name]) {
                    [result addObject:object];
                    *stop = YES;
                }
            }];
        }];
        
        return result;
    }
    
    return nil;
}

/**
 *  TaskFlow 是否注册有对应的任务
 *
 *  @param url URL Scheme
 *
 *  @return NO 被TaskFlow截获，不用再做任务处理。 YES TaskFlow没有注册对应的任务。
 */
- (BOOL) handleOpenURL:(NSURL *)url {
    NSString* scheme        = url.scheme;
    NSString* host          = url.host;
    NSString* service       = url.path;
    NSString* paramStr      = url.query;
    
    
    if ([self hasAppSchema:scheme]) {
        DLog(@"OPEN-URL: %@",url.absoluteString);
        
        NVAsObservedObject* observedObject = [self observedObjectForServiceName:service];
        
        if ([observedObject isKindOfClass:[NVAsObservedObject class]]) {
            
            if (observedObject.invokeBlock) {
                NSDictionary* parameters = nil;
                if ([service isEqualToString:@"/webImages"]) {
                    parameters        = [paramStr jsonPatameters];
                }else {
                    if (paramStr.length > 0) {
                        parameters        = [paramStr parameters];
                    }

                }
                
                NSArray* parametersSorted       = [paramStr parametersSorted];
//                NSArray* arrayNames             = [parameters allKeys];
                NSArray* publicParams            = [self hasPublicParamExisted:parametersSorted];
                
                UIWindow* window = [UIApplication sharedApplication].delegate.window;
                UIViewController* rootController = window.rootViewController;
                
                
                NSString* const kTaskNamePublicParams       = @"task.name.public.params";
                [[NVTaskManager sharedInstance] removeAllTaskWithName:kTaskNamePublicParams];
                // 是否需要 登陆/认证等，有的话 需要建立对应的任务。
                if ([publicParams count] > 0) {
                    
                    for (NVAsPublicParamObject* paramObject in publicParams) {
                        NVTask* task            = [[NVTask alloc] init];
                        task.object             = paramObject;
                        
                        NSString* value         = [parameters nvObjectForKey:paramObject.name];
                        task.userInfo           = @{@"value": value,
                                                    @"viewController": rootController};
                        
                        [[NVTaskManager sharedInstance] addTask:task
                                                           name:kTaskNamePublicParams];
                    }
                    
                    
                    [[NVTaskManager sharedInstance] start:kTaskNamePublicParams finish:^(BOOL completed) {
                        observedObject.invokeBlock(observedObject.name, parameters, rootController);
                    }];
                    
                    
                } else {
                    observedObject.invokeBlock(observedObject.name, parameters, rootController);
                }
                
                
            }
            
            return NO;
        }
    }
    
    return YES;
}


- (void) openURL:(NSURL *)url {
    BOOL result = [[NVAppSchemaObserver sharedInstance] handleOpenURL:url];
   
    if (result) {
        NSString* scheme    = url.scheme;
        if ([scheme isEqualToString:@"http"] ||
            [scheme isEqualToString:@"https"]) {
            
            NSURL* urlWeb   = [NSURL URLWithString:[NSString stringWithFormat:@"%@://Service/web?url=%@", self.appSchema, url.absoluteString]];
            [[UIApplication sharedApplication] openURL:urlWeb];
        }
    }
}

- (id) syncOpenURL:(NSURL*)url {
    NSString* scheme        = url.scheme;
    NSString* host          = url.host;
    NSString* service       = url.path;
    NSString* paramStr      = url.query;
    
    
    if ([self hasAppSchema:scheme]) {
        DLog(@"OPEN-URL: %@",url.absoluteString);
        
        NVAsObservedObject* observedObject = [self observedObjectForServiceName:service];
        
        if ([observedObject isKindOfClass:[NVAsObservedObject class]]) {
            
            if (observedObject.invokeBlock) {
                NSDictionary* parameters = nil;
                if (paramStr.length > 0) {
                    parameters        = [paramStr parameters];
                }
                NSArray* parametersSorted       = [paramStr parametersSorted];
                //                NSArray* arrayNames             = [parameters allKeys];
                NSArray* publicParams            = [self hasPublicParamExisted:parametersSorted];
                
                UIWindow* window = [UIApplication sharedApplication].delegate.window;
                UIViewController* rootController = window.rootViewController;
                return observedObject.invokeBlock(observedObject.name, parameters, rootController);
            }
        }
    }
    return  nil;
}

@end



