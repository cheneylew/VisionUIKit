//
//  NVTaskCloud.m
//  Navy
//
//  Created by Steven.Lin on 26/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVTaskCloud.h"
#import "NSDictionary+Category.h"
#import "NVStorageManager+TaskCloud.h"


@interface NVTaskCloud ()
@property (nonatomic, strong) NVTaskFlowListModel* listTaskFlow;
@end


@implementation NVTaskCloud
IMP_SINGLETON



//- (void) addFlowUrl:(NSString *)flowUrl forFlowName:(NSString *)flowName {
//    [self.dictionaryCloud nvSetObject:flowUrl forKey:flowName];
//}
//

- (NVTaskFlowDataModel*) flowUrlForName:(NSString *)flowName {
    return [self.listTaskFlow taskFlowByName:flowName];
}



- (void) initialize {
    [[NVStorageManager sharedInstance] getTaskFlowList:^(NVTaskFlowListModel *dataModel) {
        self.listTaskFlow = dataModel;
        if (self.listTaskFlow == nil) {
            [self restoreFactoryMode];
        }
    }];
}


- (void) restoreFactoryMode {
    NSDictionary* restore       = @{
                                    @"version": @"0.0",
                                    @"queryDateTime": @"20000000000",
                                    @"list" : @[
                                                @{@"name": @"invest",
                                                  @"url": @"hyhapp://Service/invest?nlogin=y",
                                                  },
                                                
                                                @{@"name": @"withdraw",
                                                  @"url": @"hyhapp://Service/withdraw?nlogin=y&nidauth=y",
                                                  },
                                                
                                                @{@"name": @"payment",
                                                  @"url": @"hyhapp://Service/payment?nlogin=y&nidauth=y",
                                                  },
                                                
                                                ],
                                    };
    
    self.listTaskFlow       = [[NVTaskFlowListModel alloc] initWithDictionary:restore];
}


- (void) synchronize {
    if (self.synchronizeBlock) {
        self.synchronizeBlock(^(NVTaskFlowListModel* listModel) {
            
            if (listModel) {
                self.listTaskFlow = listModel;
            }
            
        });
    }
}


@end


