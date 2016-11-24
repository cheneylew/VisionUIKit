//
//  NVTableViewController.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVTableViewController.h"


@interface NVTableViewController ()
<NVTableViewAdaptorDelegate>
- (void) initialize;
- (void) createTableView;
- (void) createTableAdaptor;

@end


@implementation NVTableViewController


- (void) dealloc {
    _adaptor.delegate = nil;
    
}


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
    // Do any additional setup after loading the view.
    
    [self initialize];
    
    //    UIEdgeInsets insets = self.uiTableView.contentInset;
    //    insets.top = 0.0f;
    //    insets.bottom = 70.0f;
    //    self.uiTableView.contentInset = insets;
    //    self.uiTableView.contentOffset = CGPointMake(0.0f, -0.0f);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) constructData {
    
}

- (void) initialize {
    [self createTableAdaptor];
    
    [self constructData];   //子类实现具体
    
    [self createTableView];
}

- (void) createTableView {
    
    NSString* tableViewClassName = [self.adaptor tableViewClassName];
    Class tableViewClass = NSClassFromString(tableViewClassName);
    
    CGRect frame = self.view.frame;
    _uiTableView = [[NVTableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    [_uiTableView setBackgroundColor:[UIColor clearColor]];
    [_uiTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _uiTableView.showsHorizontalScrollIndicator = NO;
    _uiTableView.showsVerticalScrollIndicator = NO;
    _uiTableView.dataSource = _adaptor;
    _uiTableView.delegate = _adaptor;
    
    _uiTableView.sectionIndexBackgroundColor = [UIColor clearColor];
    _uiTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    
    _adaptor.uiTableView = _uiTableView;
    [self.view addSubview:_uiTableView];
    [_uiTableView reloadData];
    
    self.tableViewStyle = NVTableViewStyleNormal;
}

- (void) createTableAdaptor {
    
    _adaptor = [[NVTableViewAdaptor alloc] init];
    _adaptor.delegate = self;
}

- (void) setTableViewStyle:(NVTableViewStyle)tableViewStyle {
    _tableViewStyle = tableViewStyle;
    if (_tableViewStyle == NVTableViewStyleGroup) {
        self.uiTableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 20.0f, 0.0f);
    } else {
        self.uiTableView.contentInset = UIEdgeInsetsZero;
    }
}

- (void) reloadTableViewData {
    [self.uiTableView reloadData];
    
}




@end
