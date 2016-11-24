//
//  NSObject+Category.m
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

- (BOOL) isNilOrNull {
    return (!(self && self != [NSNull null]));
}

@end
