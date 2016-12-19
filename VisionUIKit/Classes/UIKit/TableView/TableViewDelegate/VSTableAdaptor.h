//
//  VSTableAdaptor.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VSBaseDataConstructor.h"

@protocol VSTableAdaptorDelegate <NSObject>

- (void)vs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(VSTBBaseDataModel *)model;

@end

@interface VSTableAdaptor : NSObject
<UITableViewDelegate>

@property (nonatomic, weak) VSBaseDataConstructor *constructor;
@property (nonatomic, weak) id<VSTableAdaptorDelegate> delegate;

@end
