//
//  NVTableViewController.h
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

//#import "NavyUIKit.h"
#import "NVGlassMainViewController.h"
#import "NVTableViewAdaptor.h"
#import "NVTableView.h"


typedef NS_ENUM(NSUInteger, NVTableViewStyle) {
    NVTableViewStyleNormal,
    NVTableViewStyleGroup,
};

@interface NVTableViewController : NVGlassMainViewController
<UITableViewDataSource, UITableViewDelegate> {
    BOOL _isLoading;
}

@property (nonatomic, strong) NVTableView* uiTableView;         //tableView
@property (nonatomic, strong) NVTableViewAdaptor* adaptor;      //tableView delegate
@property (nonatomic, assign) NVTableViewStyle tableViewStyle;  //样式


/**
 从DataConstructor重新载入，刷新Tableview的Cell
 */
- (void) reloadTableViewData;

/**
 子类必须重写
 */
- (void) constructData;

@end

