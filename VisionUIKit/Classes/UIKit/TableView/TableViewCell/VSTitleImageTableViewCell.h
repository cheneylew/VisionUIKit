//
//  VSTitleImageTableViewCell.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/20.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSBaseTableViewCell.h"

@interface VSTBTitleIconDataModel : VSTBBaseDataModel

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *title;

@end

@interface VSTitleImageTableViewCell : VSBaseTableViewCell

@property (nonatomic, strong) UIImageView *vs_iconImageView;
@property (nonatomic, strong) UILabel *vs_keyLabel;

@end
