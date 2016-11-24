//
//  NVStorageManager+Category.h
//  Navy
//
//  Created by Jelly on 7/18/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVStorageManager.h"
#import "NVUserDataModel.h"


UIKIT_EXTERN NSString* const kStorageKeyChainUserInfo;
UIKIT_EXTERN NSString* const kStorageKeyChainAccountInfo;
//UIKIT_EXTERN NSString* const kStorageKeyChainBankCardList;
//UIKIT_EXTERN NSString* const kStoragePlistProductTDList;


@interface NVStorageManager (User)
- (void) saveUserInfo:(NVUserDataModel*)userDataModel completed:(void(^)(BOOL finish))completed;
- (void) getUserInfo:(void(^)(NVUserDataModel* dataModel))block;
- (void) getUserInfo:(void(^)(NVUserDataModel* dataModel))block classNameOfUserModel:(NSString*)className;
- (void) clearUserInfo:(void(^)(BOOL completed))completed;
@end

