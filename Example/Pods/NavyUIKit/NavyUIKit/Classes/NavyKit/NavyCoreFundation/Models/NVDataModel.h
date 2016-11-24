//
//  NVDataModel.h
//  NavyCoreFoundation
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVTableViewCellItemProtocol.h"
#import "NSDictionary+Category.h"


@interface NVDataModel : NSObject
<NVTableViewCellItemProtocol>

@property (nonatomic,copy) NSString *content;

@end



@interface NVListModel<ObjectType> : NVDataModel
@property (nonatomic, strong) NSMutableArray<ObjectType>* items;
@property (nonatomic, assign) NSInteger total;

@end

