//
//  NVBaseProcessHandler.h
//  Navy
//
//  Created by Steven.Lin on 5/3/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NVProcessHandlerProtocol.h"


@interface NVBaseProcessHandler : NSObject
<NVProcessHandlerProtocol>

@property (nonatomic, weak) UIViewController* viewController;

+ (instancetype) defaultHandler;

@end
