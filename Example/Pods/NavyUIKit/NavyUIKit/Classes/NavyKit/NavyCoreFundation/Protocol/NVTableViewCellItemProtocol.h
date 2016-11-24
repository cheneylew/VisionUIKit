//
//  NVTableViewCellItemProtocol.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NVTableViewCellItemProtocol <NSObject>

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) NSString* cellType;
@property (nonatomic, strong) NSNumber* cellHeight;
@property (nonatomic, strong) Class actionClass;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) id cellInstance;

@end
