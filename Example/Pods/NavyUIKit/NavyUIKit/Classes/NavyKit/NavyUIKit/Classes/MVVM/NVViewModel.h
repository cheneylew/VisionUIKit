//
//  NVViewModel.h
//  Navy
//
//  Created by Steven.Lin on 13/10/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVViewModelProtocol.h"


@interface NVViewModel : NSObject
<NVViewModelProtocol>
@property (nonatomic, strong) NSString* name;
@property (nonatomic, weak) id dataModel;
@property (nonatomic, copy) void(^eventBlock)(NSObject* object);
@end

