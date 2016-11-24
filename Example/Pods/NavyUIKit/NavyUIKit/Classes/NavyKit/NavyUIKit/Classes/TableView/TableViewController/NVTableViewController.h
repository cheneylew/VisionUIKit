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

@property (nonatomic, strong) NVTableView* uiTableView;
@property (nonatomic, strong) NVTableViewAdaptor* adaptor;
@property (nonatomic, assign) NVTableViewStyle tableViewStyle;
- (void) constructData;
- (void) reloadTableViewData;

@end

