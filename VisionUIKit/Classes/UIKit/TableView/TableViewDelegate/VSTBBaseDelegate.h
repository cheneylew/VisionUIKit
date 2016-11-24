//
//  VSTBBaseDelegate.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VSTBConstructor.h"

@protocol VSTBDelegate <NSObject>

- (void)vs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface VSTBBaseDelegate : NSObject
<UITableViewDelegate>

@property (nonatomic, weak) VSTBConstructor *constructor;
@property (nonatomic, weak) id<VSTBDelegate> delegate;

@end
