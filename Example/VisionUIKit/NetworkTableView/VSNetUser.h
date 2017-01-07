//
//  VSNetUser.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/5.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>

@interface VSNetUser : NSObject

PP_STRING(name);
PP_STRING(sex)
PP_ASSIGN_BASIC(double, height)

@end
