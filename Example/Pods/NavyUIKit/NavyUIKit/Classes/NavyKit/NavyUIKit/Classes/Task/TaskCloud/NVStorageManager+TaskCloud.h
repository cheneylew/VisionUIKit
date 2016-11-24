//
//  NVStorageManager+TaskCloud.h
//  Navy
//
//  Created by Steven.Lin on 26/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVStorageManager.h"
#import "NVTaskFlowDataModel.h"


UIKIT_EXTERN NSString* const kStoragePlistTaskCloud;

@interface NVStorageManager (TaskCloud)

- (void) getTaskFlowList:(void(^)(NVTaskFlowListModel* dataModel))block;
- (void) saveTaskFlowList:(NVTaskFlowListModel*)listTaskFlow completed:(void(^)(BOOL finish))completed;
- (void) clearTaskFlowList:(void(^)(BOOL completed))completed;

@end
