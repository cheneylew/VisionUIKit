//
//  NVTask.m
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVTask.h"

@implementation NVTask

- (void) execute {
    if (self.object &&
        [self.object conformsToProtocol:@protocol(NVTaskObjectProtocol)]) {
        [self.object doTaskWithUserInfo:self.userInfo callback:^(BOOL completed) {
            if (self.callback) {
                self.callback(completed);
            }
        }];
    }
}

@end

