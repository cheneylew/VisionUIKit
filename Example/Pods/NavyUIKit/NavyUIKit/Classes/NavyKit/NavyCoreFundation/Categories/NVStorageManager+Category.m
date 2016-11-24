//
//  NVStorageManager+Category.m
//  Navy
//
//  Created by Jelly on 7/18/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVStorageManager+Category.h"
#import "NVStorageOperation.h"


NSString* const kStorageKeyChainUserInfo            = @"storage.key.chain.user.info";
NSString* const kStorageKeyChainAccountInfo         = @"storage.key.chain.account.info";
//NSString* const kStorageKeyChainBankCardList        = @"storage.key.chain.bank.card.list";
//NSString* const kStoragePlistProductTDList          = @"storage.plist.product.td.list";


@implementation NVStorageManager (User)

- (void) saveUserInfo:(NVUserDataModel *)userDataModel
            completed:(void (^)(BOOL))completed {
    
    NVStorageWriteOperation* operation = [[NVStorageWriteOperation alloc] init];
    operation.policy = NVStorageOperationPolicyKeyChain;
    operation.keyName = kStorageKeyChainUserInfo;
    operation.object = [userDataModel dictionaryValue];
    operation.writeBlock = ^{
        if (completed) {
            completed(YES);
        }
    };
    
    [self.operationQueue addOperation:operation];
}

- (void) getUserInfo:(void (^)(NVUserDataModel *))block {
    
    NVStorageReadOperation* operation = [[NVStorageReadOperation alloc] init];
    operation.policy = NVStorageOperationPolicyKeyChain;
    operation.keyName = kStorageKeyChainUserInfo;
    operation.readBlock = ^(id dataModel) {
        
        if (block) {
            if ([dataModel isKindOfClass:[NSDictionary class]]) {
                NSDictionary* dictionary = (NSDictionary*)dataModel;
                
                NVUserDataModel* userInfo = [[NVUserDataModel alloc] initWithDictionary:dictionary];
                block(userInfo);
                
            } else {
                block(nil);
            }
        }
        
    };
    
    [self.operationQueue addOperation:operation];
}

- (void) getUserInfo:(void(^)(NVUserDataModel* dataModel))block classNameOfUserModel:(NSString*)className {
    NVStorageReadOperation* operation = [[NVStorageReadOperation alloc] init];
    operation.policy = NVStorageOperationPolicyKeyChain;
    operation.keyName = kStorageKeyChainUserInfo;
    operation.readBlock = ^(id dataModel) {
        
        if (block) {
            if ([dataModel isKindOfClass:[NSDictionary class]]) {
                NSDictionary* dictionary    = (NSDictionary*)dataModel;
                
                Class classInstance         = NSClassFromString(className);
                id instance                 = [[classInstance alloc] initWithDictionary:dictionary];
                block(instance);
                
            } else {
                block(nil);
            }
        }
        
    };
    
    [self.operationQueue addOperation:operation];
}

- (void) clearUserInfo:(void (^)(BOOL))completed {
    NVStorageWriteOperation* operation = [[NVStorageWriteOperation alloc] init];
    operation.policy = NVStorageOperationPolicyKeyChain;
    operation.keyName = kStorageKeyChainUserInfo;
    operation.object = @"";
    operation.writeBlock = ^{
        if (completed) {
            completed(YES);
        }
    };
    
    [self.operationQueue addOperation:operation];
}

@end


