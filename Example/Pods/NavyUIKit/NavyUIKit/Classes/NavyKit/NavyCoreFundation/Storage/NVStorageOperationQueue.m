//
//  PAStorageOperationQueue.m
//  haofang
//
//  Created by Steven.Lin on 11/21/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "NVStorageOperationQueue.h"
#import "NSDictionary+Category.h"


NSString* const kStorageQueueMemory                 = @"storage.queue.memory";
NSString* const kStorageQueuePList                  = @"storage.queue.plist";
NSString* const kStorageQueueDisk                   = @"storage.queue.disk";
NSString* const kStorageQueueCoreData               = @"storage.queue.coredata";
NSString* const kStorageQueueKeyChain               = @"storage.queue.keychain";

@interface NVStorageOperationQueue ()
@property (nonatomic, strong) NSMutableDictionary* dictionary;
@end


@implementation NVStorageOperationQueue



- (NSMutableDictionary*) dictionary {
    if (_dictionary == nil) {
        _dictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _dictionary;
}

- (void) addOperation:(NVStorageOperation *)op {
    NSString* keyName = [self keyNamePolicy:op.policy];
    if ([keyName length] == 0) {
        return;
    }
    
    NSOperationQueue* queue = [self.dictionary nvObjectForKey:keyName];
    if (![queue isKindOfClass:[NSOperationQueue class]]) {
        queue = [[NSOperationQueue alloc] init];
        [self.dictionary nvSetObject:queue forKey:keyName];
    }
    
    [queue addOperation:op];
}

- (void) addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait {
    
}

- (void) addOperationWithBlock:(void (^)(void))block {
    
}

- (void) cancelAllOperations {
    
}


- (NSString*) keyNamePolicy:(NVStorageOperationPolicy)policy {
    NSString* keyName = nil;
    NSString* arrayKeyNames[] = {
        kStorageQueueMemory,
        kStorageQueuePList,
        kStorageQueueDisk,
        kStorageQueueCoreData,
        kStorageQueueKeyChain,
    };

    if (policy >= NVStorageOperationPolicyMemory
        && policy <= NVStorageOperationPolicyKeyChain) {
        keyName = arrayKeyNames[policy];
    }
    
    return keyName;
}
@end
