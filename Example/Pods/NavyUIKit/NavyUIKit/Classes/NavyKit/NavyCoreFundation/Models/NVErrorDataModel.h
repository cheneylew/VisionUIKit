//
//  NVErrorDataModel.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVDataModel.h"
#import <UIKit/UIKit.h>
#import "NVSerializedObjectProtocol.h"


UIKIT_EXTERN NSString* const kResponseErrorTypeNeedLogin;
UIKIT_EXTERN NSString* const kResponseErrorTypeFail;
UIKIT_EXTERN NSString* const kResponseErrorTypeInvalid;
UIKIT_EXTERN NSString* const kResponseErrorTypeException;
UIKIT_EXTERN NSString* const kResponseErrorTypeError;
UIKIT_EXTERN NSString* const kResponseErrorTypeDataPurview;
UIKIT_EXTERN NSString* const kResponseErrorTypeUpgrade;
UIKIT_EXTERN NSString* const kResponseErrorTypeUpgradeForce;


@interface NVErrorDataModel : NVDataModel
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString* error;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* errorType;
@end


@interface NVExceptionDataModel : NVDataModel

@end






@interface NVSuccessDataModel : NVDataModel
<NVFundationSerializedObjectProtocol,
NVFundationDeserializedObjectProtocol>

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, assign) BOOL result;
@end


