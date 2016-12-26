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

typedef enum : NSUInteger {
    NVTBCellSelectedStyleNone,
    NVTBCellSelectedStyleCustom,
} NVTBCellSelectedStyle;

@interface NVDataModel : NSObject
<NVTableViewCellItemProtocol>

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NVTBCellSelectedStyle selectedStyle;
@property (nonatomic, strong) UIColor *normalBackgroudColor;
@property (nonatomic, strong) UIColor *selectedBackgroudColor;  //Cell选中背景色-默认白色
@property (nonatomic, assign) BOOL detailArrowIcon;

@property (nonatomic, assign) BOOL showGroupLine;                   //分组线
@property (nonatomic, strong) UIColor *groupLineColor;
@property (nonatomic, strong) NSNumber *groupLineLeft;
@property (nonatomic, strong) NSNumber *groupLineRight;

@property (nonatomic, assign) BOOL showTopLine;                   //顶部分割组线
@property (nonatomic, strong) UIColor *topLineColor;
@property (nonatomic, assign) BOOL showBottomLine;                //底部分割线
@property (nonatomic, strong) UIColor *bottomLineColor;

@end



@interface NVListModel<ObjectType> : NVDataModel
@property (nonatomic, strong) NSMutableArray<ObjectType>* items;
@property (nonatomic, assign) NSInteger total;

@end

