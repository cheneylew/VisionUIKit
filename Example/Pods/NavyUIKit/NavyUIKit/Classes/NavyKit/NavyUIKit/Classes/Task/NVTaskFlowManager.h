//
//  NVTaskFlowManager.h
//  Navy
//
//  Created by Steven.Lin on 4/2/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"
#import "NVTaskFlowParametersObjectProtocol.h"



/**
 主要用于TaskFlow的路径生成。先注册模型，后面根据模型转换成指定的路径
 */
@interface NVTaskFlowManager : NSObject
DEF_SINGLETON(NVTaskFlowManager)

/**
 APP的Schema

 @param appSchema appSchema description
 */
- (void) setLocalAppSchema:(NSString*)appSchema;

/**
 注册本地TaskFlow的Schema
 [[NVTaskFlowManager sharedInstance] registerLocalTaskFlowWithSchemaName:kProcessMapProductDetailName
 serviceName:@"/productDetail"
 parametersPath:@"id=%id%&name=%name%&type=%type%&code=%code%&nlogin=y"];

 @param schemaName     Schema名称
 @param serviceName    服务名称
 @param parametersPath 路径名称
 */
- (void) registerLocalTaskFlowWithSchemaName:(NSString*)schemaName
                                 serviceName:(NSString*)serviceName
                               parametersPath:(NSString*)parametersPath;

/**
 生成指定Schema类型的URL

 @param schemaName       Schema名称
 @param parametersObject 实现NVTaskFlowParametersObjectProtocol协议的对象

 @return hyhapp://Service/productDetail?id=10&name=产品
 */
- (NSURL*) generateLocalTaskFlowWithSchemaName:(NSString*)schemaName
                              parametersObject:(id<NVTaskFlowParametersObjectProtocol>)parametersObject;

@end
