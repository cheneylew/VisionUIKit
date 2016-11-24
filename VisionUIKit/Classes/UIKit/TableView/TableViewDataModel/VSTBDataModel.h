//
//  VSTBBaseModel.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VSTBDataModelProtocal <NSObject>

@required
@property (nonatomic, strong) NSString  *classString;
@property (nonatomic, strong) NSString  *identifier;
@property (nonatomic, strong) NSNumber   *height;

@optional
@property (nonatomic, strong) UIColor *backgroudColor;

@end

@interface VSTBDataModel : NSObject
<VSTBDataModelProtocal>

@property (nonatomic, strong) NSString  *classString;           //类的字符串名称
@property (nonatomic, strong) NSString  *identifier;            //Cell重用的识别标识
@property (nonatomic, strong) NSNumber   *height;               //Cell高度，默认Fit6P(135)

@property (nonatomic, strong) UIColor *backgroudColor;          //Cell背景色-默认白色
@property (nonatomic, strong) UIColor *selectedBackgroudColor;  //Cell选中背景色-默认白色
@property (nonatomic, assign) BOOL groupLine;                   //分组线
@property (nonatomic, strong) UIColor *groupLineColor;
@property (nonatomic, assign) BOOL detailArrowIcon;

@end
