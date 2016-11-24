//
//  PAMemoryStorage.m
//  haofang
//
//  Created by Steven.Lin on 11/24/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "NVMemoryStorage.h"
#import "NVSerializedObjectProtocol.h"
#import "NSDictionary+Category.h"


@interface NVMemoryStorage ()
@property (nonatomic, retain) NSMutableDictionary* dictionary;
@end


@implementation NVMemoryStorage


- (id) init {
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (id) readObject {
    return [self readObjectForKey:@"key"];
}

- (id) readObjectForKey:(NSString *)key {
    id object = [self.dictionary objectForKey:key];
    return object;
}

- (void) writeObject:(id)object {
    [self writeObject:object forKey:@"key"];
}

- (void) writeObject:(id)object forKey:(NSString *)key {
    if ([object conformsToProtocol:@protocol(NVFundationDeserializedObjectProtocol)]) {
        
        if ([object respondsToSelector:@selector(dictionaryValue)]) {
            NSDictionary* dictionary = [object dictionaryValue];
            [self.dictionary nvSetObject:dictionary forKey:key];
            
        } else if ([object respondsToSelector:@selector(arrayValue)]) {
            NSArray* array = [object arrayValue];
            [self.dictionary nvSetObject:array forKey:key];
        }
    } else if ([object isKindOfClass:[NSArray class]]
               || [object isKindOfClass:[NSString class]]
               || [object isKindOfClass:[NSDictionary class]]) {
        [self.dictionary nvSetObject:object forKey:key];
    }
}

@end
