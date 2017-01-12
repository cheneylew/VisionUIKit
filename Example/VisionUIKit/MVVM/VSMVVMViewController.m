//
//  VSMVVMViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/11.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSMVVMViewController.h"
#import "VSMVVMView.h"
#import "VSMVVMModel.h"
#import "VSMVVMViewModel.h"
#import <DJMacros/DJMacro.h>

@interface VSMVVMViewController ()

PP_STRONG(VSMVVMView, mvvmView)
PP_STRONG(VSMVVMModel, mvvmModel)
PP_STRONG(VSMVVMViewModel, mvvmViewModel)

@end

@implementation VSMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MVVM DEMO";
    
    self.mvvmModel = [VSMVVMModel new];
    self.mvvmModel.userName = @"cheney";
    
    self.mvvmViewModel = [VSMVVMViewModel new];
    [self.mvvmViewModel setModel:self.mvvmModel];
    
    self.mvvmView = [[VSMVVMView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    self.mvvmView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.mvvmView];
    
    [self.mvvmView setViewModel:self.mvvmViewModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"VSMVVMViewController dealloc");
}

@end
