//
//  VSNetworkDataConstructor.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/4.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSNetworkDataConstructor.h"

@implementation VSNetworkDataConstructor

- (void) vs_loadData {
    
}

- (void) vs_loadMore {
    
}

- (BOOL) vs_isDelegateValid {
    if (self.delegate) {
        return YES;
    } else {
        return NO;
    }
}

- (void)vs_callDelegateError:(id)error {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(vs_networkDataContructor:didErrorWithData:)]) {
        [self.delegate vs_networkDataContructor:self didErrorWithData:error];
    }
}

- (void)vs_callDelegateSuccess:(id)data {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(vs_networkDataContructor:didFinishWithData:)]) {
        [self.delegate vs_networkDataContructor:self didFinishWithData:data];
    }
}

- (void)vs_callDelegateShouldStartLoading {
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(vs_networkDataContructorStartLoading:)]) {
        [self.delegate vs_networkDataContructorStartLoading:self];
    }
}

@end
