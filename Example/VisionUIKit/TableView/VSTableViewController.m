//
//  VSTableViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/19.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSTableViewController.h"
#import "VSTBButtonCell.h"

@interface VSTableViewController ()
<VSTBButtonCellDelegate>


@end

@implementation VSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)vs_constructorClassName {
    return @"VSTBViewConstructor";
}

- (void)vs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(VSTBBaseDataModel *)model {
    
}

- (void)VSTBButtonCellWithButtonClickEvent:(UIButton *)btn model:(VSTBBaseDataModel *)model {
    
}

@end
