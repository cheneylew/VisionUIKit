//
//  NVErrorDataModel.m
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVErrorDataModel.h"


NSString* const kResponseErrorTypeNeedLogin     = @"ERROR.NEED.LOGIN";
NSString* const kResponseErrorTypeFail          = @"ERROR.FAIL";
NSString* const kResponseErrorTypeInvalid       = @"ERROR.INVALID";
NSString* const kResponseErrorTypeException     = @"ERROR.EXCEPTION";
NSString* const kResponseErrorTypeError         = @"ERROR.ERROR";
NSString* const kResponseErrorTypeDataPurview   = @"ERROR.DATA.PURVIEW";
NSString* const kResponseErrorTypeUpgrade       = @"ERROR.UPGRADE";
NSString* const kResponseErrorTypeUpgradeForce  = @"ERROR.UDGRADE.FORCE";


@implementation NVErrorDataModel

@end



@implementation NVExceptionDataModel

@end


@implementation NVSuccessDataModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            self.result            = [[dictionary nvObjectForKey:@"result"] boolValue];
        }
    }
    return self;
}

- (NSDictionary*) dictionaryValue {
    return @{@"result":  @(self.result)};
}

@end


