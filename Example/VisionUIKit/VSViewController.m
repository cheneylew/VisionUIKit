//
//  VSViewController.m
//  VisionUIKit
//
//  Created by Deju Liu on 11/15/2016.
//  Copyright (c) 2016 Deju Liu. All rights reserved.
//

#import "VSViewController.h"
#import "VSAlertView.h"
#import <KKCategories/KKCategories.h>
#import "VSSheetView.h"

@interface VSViewController ()

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"launch_640_1136"];
//    [self.view addSubview:imageView];
//    [self.view sendSubviewToBack:imageView];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tabBarController.navigationController.navigationBarHidden = YES;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 2000);
    [self.view addSubview:scrollView];
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor redColor];
    [scrollView addSubview:v];
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, 100, 50);
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:@"A" forState:UIControlStateNormal];
        [btn jk_addActionHandler:^(NSInteger tag) {
            self.tabBarController.navigationController.navigationBarHidden = !self.tabBarController.navigationController.navigationBarHidden;
        }];
        btn.top = v.bottom;
        [scrollView addSubview:btn];
    }
    
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(150, 0, 100, 50);
        btn.backgroundColor = [UIColor yellowColor];
        [btn setTitle:@"弹出AlertView" forState:UIControlStateNormal];
        [btn jk_addActionHandler:^(NSInteger tag) {
            UIView *f = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            f.backgroundColor = [UIColor redColor];
            [VSSheetView ShowWithCustomView:f callBlock:^(NSInteger buttonIndex) {
                //
            }];
        }];
        [scrollView addSubview:btn];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
