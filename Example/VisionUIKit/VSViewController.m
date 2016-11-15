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

    
}

- (void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(show) withObject:nil afterDelay:1];
    
}

- (void)show {
    [VSAlertView AlertWithTitle:@"111" message:@"msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg msg" buttonTitles:[NSArray arrayWithObjects:@"a",@"b", nil] callBlock:^(NSInteger buttonIndex) {
        //
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
