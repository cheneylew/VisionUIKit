//
//  VSMenuViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/12/24.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSMenuViewController.h"

@interface VSMenuViewController ()

@end

@implementation VSMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"menu";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)vs_tabItemHidden {
    return NO;
}

- (NSArray<NSString *> *)vs_tabBarNavigationBarRightItemsTitles {
    return @[@"编辑",@"打开"];
}

- (void)vs_eventTabBarNavigationBarRightItemTouchedIndex:(NSUInteger)index {
    
}

- (NSArray<NSString *> *)vs_tabBarNavigationBarLeftItemsTitles {
    return @[@"abc"];
}

- (void)vs_eventTabBarNavigationBarLeftItemTouchedIndex:(NSUInteger)index {
    
}

@end
