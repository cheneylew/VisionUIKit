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
    [self.view sendSubviewToBack:imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}
- (IBAction)click:(id)sender {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    customView.backgroundColor = [UIColor redColor];
    
    VSAlertView *a = [VSAlertView ShowAlertViewTitle:@"abc" message:@"添加到的目标视图，默认Window添加到的目标视图，默认Window添加到的目标视图，默认Window" buttonTitles:@[@"取消",@"qe"] callBlock:^(NSInteger buttonIndex) {
        //
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
