//
//  VSUserDataModel.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/16.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>
#import "VSSerializedProtocol.h"
#import "VSDataModel.h"

@interface VSUserDataModel : VSDataModel
<VSSerializedObjectProtocol,
VSDeserializedObjectProtocol>

PP_STRONG(NSString, userid)
PP_STRONG(NSString, username)
PP_STRONG(NSString, deviceinfo)
PP_STRONG(NSString, token)
PP_STRONG(NSString, mobile)
PP_STRONG(NSString, email)

@end

@interface VSUserListModel : VSListModel

@end
