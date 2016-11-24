//
//  NVReactController.m
//  Navy
//
//  Created by Steven.Lin on 18/12/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVReactController.h"

@implementation NVReactController

- (void) dealloc {
    [self clear];
}

- (NVReactor*) reactor {
    if (_reactor == nil) {
        _reactor = [[NVReactor alloc] init];
    }
    
    return _reactor;
}


- (void) reactType:(NSString *)type dataModel:(NVDataModel *)dataModel {
    
}

- (void) clear {
    [self.reactor unregisterAllObservedObjects];
}


@end
