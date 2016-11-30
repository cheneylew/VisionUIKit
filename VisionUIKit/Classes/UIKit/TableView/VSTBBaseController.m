//
//  VSTBBaseController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTBBaseController.h"
#import "VSTableView.h"
#import "VSTBAdaptor.h"
#import "VSTBConstructor.h"
#import <DJMacros/DJMacro.h>

@interface VSTBBaseController ()

@property (nonatomic, strong) VSTableView *TB;
@property (nonatomic, strong) VSTBAdaptor *TBDelegate;
@property (nonatomic, strong) VSTBConstructor *TBConstructor;

@end

@implementation VSTBBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"table view";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView {
    self.TBConstructor = [[NSClassFromString([self vs_constructorClassName]) alloc] init];
    self.TBConstructor.controller = self;
    self.TBDelegate = [[VSTBAdaptor alloc] init];
    self.TBDelegate.constructor = self.TBConstructor;
    self.TBDelegate.delegate = self;
    
    VSTableView *TB = [[VSTableView alloc] initWithFrame:self.view.bounds
                                                   style:UITableViewStylePlain];
    [TB setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    TB.delegate     = self.TBDelegate;
    TB.dataSource   = self.TBConstructor;
    TB.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.TB         = TB;
    [self.view addSubview:TB];
    
    
    self.TBConstructor.TB = TB;
    
    [self.TBConstructor loadModels];
    [self.TB reloadData];
}

- (NSString *)vs_constructorClassName {
    METHOD_NOT_IMPLEMENTED();
    return @"";
}

@end
