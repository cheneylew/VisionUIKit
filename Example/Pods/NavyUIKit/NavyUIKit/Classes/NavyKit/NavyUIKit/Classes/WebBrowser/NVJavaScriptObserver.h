//
//  NVJavaScriptObserver.h
//  Navy
//
//  Created by Steven.Lin on 11/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVSingleton.h"
#import "NVJsObservedObject.h"



@interface NVJavaScriptObserver : NSObject

DEF_SINGLETON(NVJavaScriptObserver)

- (void) addObserverName:(NSString*)name
                  jsName:(NSString*)jsName
                  invoke:(void(^)(NSString* name, NSArray* args, UIViewController* viewController))block;
- (NSDictionary*) observer;

@end
