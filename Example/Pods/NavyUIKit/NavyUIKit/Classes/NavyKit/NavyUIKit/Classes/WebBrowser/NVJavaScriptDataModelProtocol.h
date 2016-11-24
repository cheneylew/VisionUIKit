//
//  NVJavaScriptDataModelProtocol.h
//  Navy
//
//  Created by Steven.Lin on 12/11/15.
//  Copyright © 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol NVJavaScriptDataModelProtocol <NSObject>
- (id) initWithArgs:(NSArray*)array;
- (NSArray*) argsValue;
- (BOOL) available:(NSArray*)argsValue;
@end
