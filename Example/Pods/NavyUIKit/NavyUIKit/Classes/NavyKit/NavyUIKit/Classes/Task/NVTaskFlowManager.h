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



@interface NVTaskFlowManager : NSObject
DEF_SINGLETON(NVTaskFlowManager)

- (void) setLocalAppSchema:(NSString*)appSchema;

- (void) registerLocalTaskFlowWithSchemaName:(NSString*)schemaName
                                 serviceName:(NSString*)serviceName
                               parametersPath:(NSString*)parametersPath;

- (NSURL*) generateLocalTaskFlowWithSchemaName:(NSString*)schemaName
                              parametersObject:(id<NVTaskFlowParametersObjectProtocol>)parametersObject;

@end
