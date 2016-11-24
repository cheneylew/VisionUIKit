//
//  PAStorageOperation.m
//  haofang
//
//  Created by Steven.Lin on 11/21/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "NVStorageOperation.h"
#import "NVPlistStorage.h"
#import "NVMemoryStorage.h"
#import "NVKeyChainStorage.h"

@interface NVStorageOperation ()
- (id<NVFundationStorageProtocol>) instance:(NVStorageOperationPolicy)policy;
@end



@implementation NVStorageOperation

static NVPlistStorage* plistStorageInstance() {
    static NVPlistStorage* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NVPlistStorage alloc] initWithFileName:@"db.cache"];
    });
    
    return instance;
}

static NVMemoryStorage* memoryStorageInstance() {
    static NVMemoryStorage* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NVMemoryStorage alloc] init];
    });
    
    return instance;
}

static NVKeyChainStorage* keyChainStorageInstance() {
    static NVKeyChainStorage* instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NVKeyChainStorage alloc] init];
    });
    
    return instance;
}

- (id<NVFundationStorageProtocol>) instance:(NVStorageOperationPolicy)policy {

    switch (policy) {
        case NVStorageOperationPolicyMemory:
            return memoryStorageInstance();
        case NVStorageOperationPolicyPList:
            return plistStorageInstance();
        case NVStorageOperationPolicyKeyChain:
            return keyChainStorageInstance();
        default:
            break;
    }
    
    return nil;
}

@end




@implementation NVStorageReadOperation

- (void) start {
    
    id<NVFundationStorageProtocol> storage = [self instance:self.policy];
    if ([self.keyName length] > 0) {
        id object = [storage readObjectForKey:self.keyName];
        if (self.readBlock) {
            self.readBlock(object);
        }
    }
}

@end



@implementation NVStorageWriteOperation

- (void) start {
    
    id<NVFundationStorageProtocol> storage = [self instance:self.policy];
    if ([self.keyName length] > 0) {
        [storage writeObject:self.object forKey:self.keyName];
        if (self.writeBlock) {
            self.writeBlock();
        }
    }
}
@end



@implementation NVStorageDeleteOperation

- (void) start {
    
    id<NVFundationStorageProtocol> storage = [self instance:self.policy];
    if ([self.keyName length] > 0) {

    }
}

@end
