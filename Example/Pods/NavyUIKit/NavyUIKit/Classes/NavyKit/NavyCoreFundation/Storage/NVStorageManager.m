//
//  PAStorageManager.m
//  haofang
//
//  Created by Steven.Lin on 11/18/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "NVStorageManager.h"


@interface NVStorageManager ()
@end



@implementation NVStorageManager
//@synthesize storagePlist = _storagePlist;

IMP_SINGLETON

- (id) init {
    self = [super init];
    if (self) {
        _operationQueue = [[NVStorageOperationQueue alloc] init];
        
//        _storagePlist = [[PAPlistStorage alloc] initWithFileName:@"cache.db"];
        
    }
    return self;
}

- (void)writeObject
{
    // TODO: 去警告实现
}


- (void) readObjectWithKeyName:(NSString *)keyName block:(void (^)(id))block {
    
    NVStorageReadOperation* operation = [[NVStorageReadOperation alloc] init];
    operation.policy = NVStorageOperationPolicyPList;
    operation.keyName = keyName;
    operation.readBlock = block;
    [self.operationQueue addOperation:operation];
}

@end






@implementation NVStorageManager (Transfer)


- (void) transferWithKeyName:(NSString *)keyName
                        from:(NVStorageOperationPolicy)fromPolicy
                          to:(NVStorageOperationPolicy)toPolicy
                   completed:(void (^)(BOOL))completed {
    
    [self transferWithKeyName:keyName
                         from:fromPolicy
                           to:toPolicy
                    overwrite:YES
                     reserved:YES
                    completed:completed];
}


- (void) transferWithKeyName:(NSString *)keyName
                        from:(NVStorageOperationPolicy)fromPolicy
                          to:(NVStorageOperationPolicy)toPolicy
                   overwrite:(BOOL)overwrite
                    reserved:(BOOL)reserved
                   completed:(void (^)(BOOL))completed {
    
    NVStorageReadOperation* opRead = [[NVStorageReadOperation alloc] init];
    opRead.policy = fromPolicy;
    opRead.keyName = keyName;
    opRead.readBlock = ^(id object) {
        
        if (![object isKindOfClass:[NSNull class]]) {
            
            if (!reserved) {
                NVStorageDeleteOperation* opDelete = [[NVStorageDeleteOperation alloc] init];
                opDelete.policy = fromPolicy;
                opDelete.keyName = keyName;
                [self.operationQueue addOperation:opDelete];
            }
            
            NVStorageReadOperation* opRead = [[NVStorageReadOperation alloc] init];
            opRead.policy = toPolicy;
            opRead.keyName = keyName;
            opRead.readBlock = ^(id object) {
                
                if (object == nil || [object isKindOfClass:[NSNull class]]) {
                    if (completed) {
                        completed(NO);
                    }
                    return;
                }
                
                NVStorageWriteOperation* opWrite = [[NVStorageWriteOperation alloc] init];
                opWrite.policy = toPolicy;
                opWrite.keyName = keyName;
                opWrite.object = object;
                opWrite.writeBlock = ^(void) {
                    if (completed) {
                        completed(YES);
                    }
                };
                [self.operationQueue addOperation:opWrite];
                
            };
            [self.operationQueue addOperation:opRead];
            
        }
        
        
    };
    [self.operationQueue addOperation:opRead];
}


@end