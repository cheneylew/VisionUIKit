//
//  NVAsVariableVariantObject.m
//  Navy
//
//  Created by Steven.Lin on 25/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVAsVariableVariantObserver.h"


NSString* const kVVProductIdKeyName         = @"vv.product.id";
NSString* const kVVUserIdKeyName            = @"vv.user.id";
NSString* const kVVHoldIdKeyName            = @"vv.hold.id";


@interface NVAsVariableVariantObserver ()
@property (nonatomic, strong) NSMutableDictionary* dictionaryVariants;
@end


@implementation NVAsVariableVariantObserver
IMP_SINGLETON

- (NSMutableDictionary*) dictionaryVariants {
    if (_dictionaryVariants == nil) {
        _dictionaryVariants = [NSMutableDictionary dictionary];
    }
    
    return _dictionaryVariants;
}

- (void) addVariantName:(NSString *)variantName variantTag:(NSString *)variantTag {
    if ([variantName length] > 0 &&
        [variantTag length] > 0) {
        [self.dictionaryVariants setObject:variantTag forKey:variantName];
    }
}

- (NSString*) fillinWithSchemeUrl:(NSString *)schemeUrl filledValue:(NSString *(^)(NSString *))filledValue {
    __block NSString* result = [NSString stringWithString:schemeUrl];
    
    NSArray* allKeys    = [self.dictionaryVariants allKeys];
    [allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* key   = (NSString*)obj;
        if ([result rangeOfString:key].length > 0) {
            NSString* variantTag = [self.dictionaryVariants objectForKey:key];
            if (filledValue) {
                NSString* value = filledValue(variantTag);
                result = [result stringByReplacingOccurrencesOfString:key withString:value];
            }
        }
    }];
    
    return result;
}

@end






