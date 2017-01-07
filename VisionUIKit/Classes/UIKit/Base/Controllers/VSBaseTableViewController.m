//
//  VSTBBaseController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSBaseTableViewController.h"
#import "VSTableView.h"
#import "VSTableAdaptor.h"
#import "VSNormalDataConstructor.h"
#import <DJMacros/DJMacro.h>

@interface VSBaseTableViewController ()

@end

@implementation VSBaseTableViewController

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
    self.TBConstructor = [[[self vs_constructorClass] alloc] init];
    self.TBConstructor.delegateController = self;
    if ([self.TBConstructor isKindOfClass:[VSNetworkDataConstructor class]]) {
        self.TBNetworkConstructor = (VSNetworkDataConstructor *)self.TBConstructor;
        self.TBNetworkConstructor.delegate = self;
    }
    
    self.TBDelegate = [[VSTableAdaptor alloc] init];
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

- (void)vs_reloadAllData {
//    [self.TBConstructor.dataModels removeAllObjects];
//    [self.TBConstructor vs_addModels];
    [self.TB reloadData];
}

- (void)vs_reloadIndex:(NSUInteger) index {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.TB reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)vs_reloadIndexPath:(NSIndexPath *) indexPath {
    [self.TB reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)vs_reloadIndexPaths:(NSArray<NSIndexPath *> *) indexPaths {
    [self.TB reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
}

- (Class )vs_constructorClass {
    METHOD_NOT_IMPLEMENTED();
    return nil;
}

- (void)vs_constructorData {
    
}

@end
