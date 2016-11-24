//
//  NVAsPublicParamObject.m
//  Navy
//
//  Created by Steven.Lin on 7/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import "NVAsPublicParamObject.h"
#import "NSDictionary+Category.h"


@implementation NVAsPublicParamObject

- (void) doTaskWithUserInfo:(NSDictionary *)userInfo callback:(void (^)(BOOL))callback {
    
    if (self.invokeBlock) {
        NSString* value                     = [userInfo nvObjectForKey:@"value"];
        UIViewController* viewController    = [userInfo nvObjectForKey:@"viewController"];
        
        self.invokeBlock(self.name, value, viewController, ^(BOOL completed){
            if (callback) {
                callback(completed);
            }
        });
        
    } else {
        if (callback) {
            callback(NO);
        }
    }
}



@end



