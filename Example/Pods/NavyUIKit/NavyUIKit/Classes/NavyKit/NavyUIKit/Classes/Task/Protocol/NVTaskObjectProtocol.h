//
//  NVTaskObjectProtocol.h
//  Navy
//
//  Created by Steven.Lin on 21/1/16.
//  Copyright © 2016 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NVTaskObjectProtocol <NSObject>
- (void) doTaskWithUserInfo:(NSDictionary*)userInfo callback:(void(^)(BOOL completed))callback;
@end
