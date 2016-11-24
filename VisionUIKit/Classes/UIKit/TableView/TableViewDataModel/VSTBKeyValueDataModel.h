//
//  VSTBKeyValueDataModel.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBDataModel.h"

@interface VSTBKeyValueDataModel : VSTBDataModel

@property (nonatomic, strong) NSString *key;    //左侧-标题  空位不显示
@property (nonatomic, strong) NSString *value;  //右侧-描述  空为不显示

@end
