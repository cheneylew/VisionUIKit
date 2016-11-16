//
//  VSViewController.m
//  VisionUIKit
//
//  Created by Deju Liu on 11/15/2016.
//  Copyright (c) 2016 Deju Liu. All rights reserved.
//

#import "VSViewController.h"
#import "VSAlertView.h"

@interface VSViewController ()

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"launch_640_1136"];
    [self.view addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(show) withObject:nil afterDelay:0.5];
    
}

- (void)show {
    [VSAlertView AlertWithTitle:@"111" message:@"账户页面切换过程中发现有时候会出现遮挡的情况 而且页面回不去。只有切到其他页面再切回来才能恢复账户页面切换过程中发现有时候会出现遮挡的情况 而且页面回不去。只有切到其他页面再切回来才能恢复账户页面切换过程中发现有时候会出现遮挡的情况 而且页面回不去。只有切到其他页面再切回来才能恢复" buttonTitles:[NSArray arrayWithObjects:@"取消",@"实名认证", nil] callBlock:^(NSInteger buttonIndex) {
        //
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
