//
//  NVNoAnimationLayer.m
//  Navy
//
//  Created by Steven.Lin on 21/7/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVNoAnimationLayer.h"

@implementation NVNoAnimationLayer

- (nullable id<CAAction>)actionForKey:(NSString *)event {
    return nil;
}


@end
