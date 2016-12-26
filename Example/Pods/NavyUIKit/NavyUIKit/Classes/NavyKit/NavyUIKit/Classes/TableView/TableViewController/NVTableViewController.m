//
//  NVTableViewController.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewController.h"
#import <DJMacros/DJMacro.h>

@interface NVTableViewController ()
<NVTableViewAdaptorDelegate>
- (void) initialize;
- (void) createTableView;
- (void) createTableAdaptor;

@end


@implementation NVTableViewController


#pragma mark - Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initialize];
}

- (void) dealloc {
    _adaptor.delegate = nil;
}

#pragma mark - 初始化构建
- (void) initialize {
    [self createTableAdaptor];
    [self constructData];   //子类实现具体
    [self createTableView];
}

- (void) constructData {
    METHOD_NOT_IMPLEMENTED();
}

- (void) createTableAdaptor {
    _adaptor = [[NVTableViewAdaptor alloc] init];
    _adaptor.delegate = self;
}

- (void) createTableView {
    
    //NSString* tableViewClassName = [self.adaptor tableViewClassName];
    //Class tableViewClass = NSClassFromString(tableViewClassName);
    
    _uiTableView = [[NVTableView alloc] initWithFrame:self.view.bounds];
    [_uiTableView setBackgroundColor:[UIColor clearColor]];
    [_uiTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _uiTableView.showsHorizontalScrollIndicator     = NO;
    _uiTableView.showsVerticalScrollIndicator       = NO;
    _uiTableView.dataSource                         = _adaptor;
    _uiTableView.delegate                           = _adaptor;
    
    _uiTableView.sectionIndexBackgroundColor        = [UIColor clearColor];
    _uiTableView.sectionIndexTrackingBackgroundColor= [UIColor clearColor];
    
    _adaptor.uiTableView = _uiTableView;
    [self.view addSubview:_uiTableView];
    [_uiTableView reloadData];
    
    self.tableViewStyle = NVTableViewStyleNormal;
}

- (void) reloadTableViewData {
    [self.uiTableView reloadData];
}

#pragma mark - Setter/Getter
- (void) setTableViewStyle:(NVTableViewStyle)tableViewStyle {
    _tableViewStyle = tableViewStyle;
    if (_tableViewStyle == NVTableViewStyleGroup) {
        //可能造成Tableview下方偏移20.0f
        //self.uiTableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 20.0f, 0.0f);
    } else {
        self.uiTableView.contentInset = UIEdgeInsetsZero;
    }
}




@end
