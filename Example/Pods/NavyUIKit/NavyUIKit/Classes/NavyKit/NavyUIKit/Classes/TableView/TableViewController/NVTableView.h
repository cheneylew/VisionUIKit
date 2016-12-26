//
//  NVTableView.h
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 @property
 @abstract      继承UITableViewDataSource.
 设置某个section是否分组
 */
@protocol NVTableViewDataSource <NSObject, UITableViewDataSource>
@optional
- (BOOL) tableView:(UITableView *)tableView enableGroupModeAtSection:(NSInteger)section;
@end



@interface NVTableView : UITableView
@property (nonatomic, weak) id<NVTableViewDataSource> dataSource;
@end

