//
//  User.m
//  Test
//
//  Created by Dejun Liu on 2017/1/23.
//  Copyright © 2017年 xiaolu zhao. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithId:(NSInteger) userId
{
    self = [super init];
    if (self) {
        self.userId = userId;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    User *copy = [[[self class] allocWithZone:zone] init];
    copy.userId = self.userId;
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    User *copy = [[[self class] allocWithZone:zone] init];
    copy.userId = self.userId;
    return copy;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"userid: %ld", (long)self.userId];
}

@end
