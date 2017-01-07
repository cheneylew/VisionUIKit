//
//  VSNetworkTableViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/4.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSNetworkTableViewController.h"
#import "VSNetworkMyConstructor.h"
#import "VSTitleDetailTableViewCell.h"
#import "VSTitleFieldTableViewCell.h"

@interface VSNetworkTableViewController ()
<VSTitleFieldTableViewCellDelegate>

@end

@implementation VSNetworkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.TBNetworkConstructor vs_loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Class)vs_constructorClass {
    return [VSNetworkMyConstructor class];
}

- (void)vs_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(VSTBBaseDataModel *)model {
    NSString *identifier = model.identifier;
    if ([identifier isEqualToString:@"com.cell.a"]) {
        VSTBTitleDetailDataModel *m1 = model;
        m1.value = @"hello world";
        NSIndexPath *indexPath = [self.TBConstructor vs_indexPathOfModel:model];
        [self vs_reloadIndexPath:indexPath];
    }
}

- (void)vs_titleFieldTableViewCellChangedText:(NSString *)text model:(VSTBBaseDataModel *)model {
    VSTBTitleDetailDataModel *m = [self.TBConstructor vs_modelAtIndex:0];
    m.value = text;
    [self vs_reloadIndex:0];
}

- (void)vs_networkDataContructorStartLoading:(VSNetworkDataConstructor *)dataConstructor {
    
}

- (void)vs_networkDataContructor:(VSNetworkDataConstructor *)dataConstructor didFinishWithData:(id)data {
    [self.TBNetworkConstructor vs_addModels];
    [self vs_reloadAllData];
}

- (void)vs_networkDataContructor:(VSNetworkDataConstructor *)dataConstructor didErrorWithData:(id)data {
    
}

@end
