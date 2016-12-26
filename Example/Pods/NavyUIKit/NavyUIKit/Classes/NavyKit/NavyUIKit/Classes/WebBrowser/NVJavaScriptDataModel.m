//
//  NVJavaScriptDataModel.m
//  Navy
//
//  Created by Steven.Lin on 12/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import "NVJavaScriptDataModel.h"
#import <objc/runtime.h>


@implementation NVJavaScriptDataModel

- (id) initWithArgs:(NSArray *)array {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSArray*) argsValue {
    return @[];
}

- (BOOL) available:(NSArray*)argsValue {
    unsigned int count;
    //objc_property_t* properties = class_copyPropertyList([self class], &count);
    
    return (count == [argsValue count]);
}

@end
