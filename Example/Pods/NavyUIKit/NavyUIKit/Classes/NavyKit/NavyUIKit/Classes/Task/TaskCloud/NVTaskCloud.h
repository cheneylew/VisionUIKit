//
//  NVTaskCloud.h
//  Navy
//
//  Created by Steven.Lin on 26/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVSingleton.h"
#import "NVTaskFlowDataModel.h"



@interface NVTaskCloud : NSObject
DEF_SINGLETON(NVTaskCloud)
@property (nonatomic, copy) void(^synchronizeBlock)(void(^callBack)(NVTaskFlowListModel* listModel));


- (void) initialize;
- (void) restoreFactoryMode;
- (void) synchronize;
- (NVTaskFlowDataModel*) flowUrlForName:(NSString*)flowName;

@end
