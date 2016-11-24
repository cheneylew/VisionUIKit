//
//  NVAsPublicParamObject.h
//  Navy
//
//  Created by Steven.Lin on 7/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVTaskObjectProtocol.h"

typedef void(^PublicParamInvoke) (NSString* name, NSString* value, UIViewController* viewController, void(^callback)(BOOL completed));


@interface NVAsPublicParamObject : NSObject
<NVTaskObjectProtocol>
@property (nonatomic, strong) NSString* name;
@property (nonatomic, copy) PublicParamInvoke invokeBlock;
@end





