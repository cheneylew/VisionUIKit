//
//  VSTBTableViewCell.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSTBDataModel.h"

@interface VSTBTableViewCell : UITableViewCell


/**
 子类重写
 */
- (void)initUI;
- (void)setCellModel:(VSTBDataModel *)cellModel;

@end
