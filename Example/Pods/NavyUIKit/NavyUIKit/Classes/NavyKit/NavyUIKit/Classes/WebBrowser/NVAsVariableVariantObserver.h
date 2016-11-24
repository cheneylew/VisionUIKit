//
//  NVAsVariableVariantObject.h
//  Navy
//
//  Created by Steven.Lin on 25/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NVSingleton.h"


UIKIT_EXTERN NSString* const kVVProductIdKeyName;
UIKIT_EXTERN NSString* const kVVUserIdKeyName;
UIKIT_EXTERN NSString* const kVVHoldIdKeyName;



@interface NVAsVariableVariantObserver : NSObject
DEF_SINGLETON(NVAsVariableVariantObserver)

- (void) addVariantName:(NSString*)variantName variantTag:(NSString*)variantTag;

- (NSString*) fillinWithSchemeUrl:(NSString*)schemeUrl
                      filledValue:(NSString*(^)(NSString* variantTag))filledValue;

@end
