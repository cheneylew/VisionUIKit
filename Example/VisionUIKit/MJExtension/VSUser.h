//
//  VSUser.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/25.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DJMacros/DJMacro.h>
#import <MJExtension/MJExtension.h>

@interface VSUser : NSObject

PP_STRING(name)
PP_STRING(sex)

PP_STRONG(NSArray, books)

@end

@interface VSBook : NSObject

PP_STRONG(NSString, name)

@end
