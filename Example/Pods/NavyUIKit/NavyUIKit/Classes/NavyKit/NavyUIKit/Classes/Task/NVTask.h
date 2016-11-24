//
//  NVTask.h
//  Navy
//
//  Created by Steven.Lin on 20/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVTaskObjectProtocol.h"

@interface NVTask : NSObject
@property (nonatomic, strong) id<NVTaskObjectProtocol> object;
@property (nonatomic, strong) NSDictionary* userInfo;
@property (nonatomic, copy) void(^callback)(BOOL completed);
- (void) execute;
@end
