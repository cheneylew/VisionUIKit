//
//  VSKeyValueTBVC.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSBaseTBVC.h"

@interface VSTBKeyValueDataModel : VSTBBaseDataModel

@property (nonatomic, strong) NSString *key;    //左侧-标题  空位不显示
@property (nonatomic, strong) UIColor *keyColor;
@property (nonatomic, strong) UIFont *keyFont;
@property (nonatomic, strong) NSNumber *keyLeft;

@property (nonatomic, strong) NSString *value;  //右侧-描述  空为不显示
@property (nonatomic, strong) UIColor *valueColor;
@property (nonatomic, strong) UIFont *valueFont;
@property (nonatomic, strong) NSNumber *valueRight;

@end

@interface VSKeyValueTBVC : VSBaseTBVC

@property (nonatomic, strong) UILabel *vs_keyLabel;
@property (nonatomic, strong) UILabel *vs_valueLabel;

@end
