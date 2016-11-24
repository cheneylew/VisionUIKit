//
//  NVJsObserverObject.h
//  Navy
//
//  Created by Steven.Lin on 11/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^invoke) (NSString* name, NSArray* args, UIViewController* viewController);

@interface NVJsObservedObject : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* jsName;
@property (nonatomic, copy) invoke invokeBlock;

@end
