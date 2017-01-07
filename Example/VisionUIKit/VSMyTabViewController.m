//
//  VSMyTabViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/7.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSMyTabViewController.h"
#import "VSMenuViewController.h"
#import "VSViewController.h"
#import <KKCategories/KKCategories.h>

@interface VSMyTabViewController ()

@end

@implementation VSMyTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllers = @[[VSViewController new],
                             [VSMenuViewController new]];
    self.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
