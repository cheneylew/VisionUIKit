//
//  NVReactController.h
//  Navy
//
//  Created by Steven.Lin on 18/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVReactor.h"
#import "NVTableViewDataConstructor.h"


@interface NVReactController : NSObject
@property (nonatomic, strong) NVReactor* reactor;
@property (nonatomic, weak) NVTableViewDataConstructor* dataConstructor;

- (void) reactType:(NSString*)type dataModel:(NVDataModel*)dataModel;
- (void) clear;

@end
