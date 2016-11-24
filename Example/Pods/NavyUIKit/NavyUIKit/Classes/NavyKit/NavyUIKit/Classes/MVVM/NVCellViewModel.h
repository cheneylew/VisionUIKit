//
//  NVCellViewModel.h
//  Navy
//
//  Created by Steven.Lin on 13/10/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVViewModelProtocol.h"
#import "NVTableViewCellItemProtocol.h"


@interface NVCellViewModel : NSObject
<NVViewModelProtocol,
NVTableViewCellItemProtocol>


@end
