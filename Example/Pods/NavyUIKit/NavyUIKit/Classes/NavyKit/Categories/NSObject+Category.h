//
//  NSObject+Category.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (Category)

/*!
 @method
 @abstract      判断对象是否未nil或[NSNull null]对象
 @return        BOOL
 */
- (BOOL) isNilOrNull;

@end
