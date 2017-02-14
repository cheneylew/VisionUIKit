//
//  User.h
//  Test
//
//  Created by Dejun Liu on 2017/1/23.
//  Copyright © 2017年 xiaolu zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
<NSCopying,
NSMutableCopying>

@property (nonatomic, assign) NSInteger userId;

- (instancetype)initWithId:(NSInteger) userId;

@end
