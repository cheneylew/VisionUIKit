//
//  VSTBAdaptor.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VSTBConstructor.h"

@protocol VSTBAdaptorDelegate <NSObject>

- (void)vs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(VSTBBaseDataModel *)model;

@end

@interface VSTBAdaptor : NSObject
<UITableViewDelegate>

@property (nonatomic, weak) VSTBConstructor *constructor;
@property (nonatomic, weak) id<VSTBAdaptorDelegate> delegate;

@end
