//
//  NVAppSchemaObserver.h
//  Navy
//
//  Created by Steven.Lin on 15/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NVSingleton.h"
#import "NVAsObservedObject.h"
#import "NVAsPublicParamObject.h"


@interface NVAppSchemaObserver : NSObject
DEF_SINGLETON(NVAppSchemaObserver)

@property (nonatomic, strong, readonly) NSString* appSchema;

- (void) setAppSchema:(NSString*)appSchema;
- (BOOL) hasAppSchema:(NSString*)urlSchema;

- (void) addPublicParamName:(NSString*)paramName
                     invoke:(void(^)(NSString* paramName, NSString* paramValue, UIViewController* viewController, void(^callback)(BOOL completed)))block;

- (void) addObserverName:(NSString*)name
             serviceName:(NSString*)serviceName
                  invoke:(id (^)(NSString* name, NSDictionary* parameters, UIViewController* viewController))block;

//- (void) addObserverName:(NSString *)name
//                 webName:(NSString *)webName
//                  invoke:(void (^)(NSString* name, NSDictionary* parameters, UIViewController* viewController))block;

- (NVAsObservedObject*) observedObjectForServiceName:(NSString*)serviceName;
- (NVAsPublicParamObject*) publicParamObjectForParamName:(NSString*)paramName;
- (NSArray*) hasPublicParamExisted:(NSArray*)paramNames;


- (BOOL) handleOpenURL:(NSURL*)url;

/**
 异步方式 打开一个服务

 @param url 服务的URL
 */
- (void) openURL:(NSURL*)url;

/**
 同步方式 打开一个服务 立即返回结果

 @param url 服务URL
 */
- (id) syncOpenURL:(NSURL*)url;


- (NSURL*) generateAppUrlWithSchemaName:(NSString*)schemaName;



@end




