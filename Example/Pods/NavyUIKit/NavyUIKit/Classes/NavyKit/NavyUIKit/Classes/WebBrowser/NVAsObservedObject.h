//
//  NVAsObservedObject.h
//  Navy
//
//  Created by Steven.Lin on 15/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef id (^AppSchemaInvoke) (NSString* name, NSDictionary* parameters, UIViewController* viewController);


@interface NVAsObservedObject : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* serviceName;
@property (nonatomic, copy) AppSchemaInvoke invokeBlock;
@end
