//
//  NVViewModelProtocol.h
//  Navy
//
//  Created by Steven.Lin on 13/10/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVViewModelCommand.h"
#import "NVViewModelObserver.h"


@protocol NVViewModelProtocol <NSObject>
@property (nonatomic, strong) NVViewModelCommand* command;
@property (nonatomic, strong) NVViewModelObserver* observer;
@end
