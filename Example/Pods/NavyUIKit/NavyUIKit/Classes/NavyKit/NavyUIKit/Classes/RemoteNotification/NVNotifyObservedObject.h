//
//  NVNotifyObservedObject.h
//  Navy
//
//  Created by Steven.Lin on 16/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NotifyInvoke) (NSString* name, NSDictionary* parameters);


@interface NVNotifyObservedObject : NSObject
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* notifyName;
@property (nonatomic, copy) NotifyInvoke invokeBlock;
@end

