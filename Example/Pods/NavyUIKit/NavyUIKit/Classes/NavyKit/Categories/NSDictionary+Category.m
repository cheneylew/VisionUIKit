//
//  NSDictionary+Category.m
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NSDictionary+Category.h"
#import "NSObject+Category.h"


@implementation NSDictionary (Category)

- (id)nvObjectForKey:(NSString *)key {
    if (key == nil || [self isNilOrNull]) {
        return nil;
    }
    id object = [self objectForKey:key];
    if (object==nil || object == [NSNull null]) {
        return @"";
    }
    return object;
}


- (void)nvSetObject:(id)object forKey:(id)key {
    if ([key isNilOrNull]) {
        return;
    }
    if ([object isNilOrNull]) {
        [self setValue:@"" forKey:key];
    }else{
        [self setValue:object forKey:key];
    }
}

- (id)objectForKeyCustom:(id)aKey {
    id object   = nil;
    
    // 检查是否字典对象
    if (![self isKindOfClass:[NSDictionary class]]) {
        return object;
    }
    
    // 保证key必须为字符串
    if (aKey && [aKey isKindOfClass:[NSString class]]) {
        object  = [self objectForKeyCustom:aKey];
    }
    
    return object;
}

- (id)nvKeyForValue:(id)value {
    for (id key in self.allKeys) {
        if ([value isEqual:[self objectForKey:key]]) {
            return key;
        }
    }
    return nil;
}


@end
