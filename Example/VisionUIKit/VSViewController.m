//
//  VSViewController.m
//  VisionUIKit
//
//  Created by Deju Liu on 11/15/2016.
//  Copyright (c) 2016 Deju Liu. All rights reserved.
//

#import "VSViewController.h"
#import "VSAlertView.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>
#import "VSSheetView.h"
#import "VSTableViewController.h"

#define TITLE_COLOR RGB(15, 103, 197)

@interface VSViewController ()

PP_STRONG(UIScrollView, scrollView)

@end

@implementation VSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.title = @"效果展示";
    self.view.backgroundColor = RGB(245, 245, 245);
    [self makeScrollView];
    [self makeLeftButtons];
    [self makeRightButtons];
}


- (void)viewWillAppear:(BOOL)animated {
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 定制按钮

- (void)makeLeftButtons{
    [[self makeLeftButton:@"SheetView" index:0] jk_addActionHandler:^(NSInteger tag) {
        [VSSheetView ShowWithbuttonTitles:@[@"相机",@"相册"] cancelTitle:@"取消" callBlock:^(NSInteger buttonIndex) {
            //
        }];
    }];
    
    [[self makeLeftButton:@"SheetView_Custom" index:1] jk_addActionHandler:^(NSInteger tag) {
        UIView *f = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        f.backgroundColor = [UIColor redColor];
        [VSSheetView ShowWithCustomView:f callBlock:^(NSInteger buttonIndex) {
            
        }];
    }];
    
    [[self makeLeftButton:@"AlertView-类系统" index:2] jk_addActionHandler:^(NSInteger tag) {
        [VSAlertView ShowWithTitle:@"提示" message:@"标题" buttonTitles:@[@"确定",@"取消"] callBlock:^(NSInteger buttonIndex) {
            //
        }];
    }];
    
    [[self makeLeftButton:@"AlertView-点击蒙版关闭" index:3] jk_addActionHandler:^(NSInteger tag) {
        VSAlertView *alertView = [VSAlertView ShowWithTitle:nil message:@"有市场就得上呗君不见微软发布会上那么多信仰灯况且现在微软也跟着苹果学坏了搞高调撩妹式营销生产端来渗透MAC用户市场也是很正常的事情有市场就得上呗君不见微软发布会上那么多信仰灯况且现在微软也跟着苹果学坏了搞高调撩妹式营销生产端来渗透MAC用户市场也是很正常的事情有市场就得上呗君不见微软发布会上那么多信仰灯况且现在微软也跟着苹果学坏了搞高调撩妹式营销生产端来渗透MAC用户市场也是很正常的事情" buttonTitles:nil callBlock:^(NSInteger buttonIndex) {
            //
        }];
        [alertView enableTapMaskClose:YES];
    }];
}

- (void)makeRightButtons{
    [[self makeRightButton:@"隐藏显示NavigationBar" index:0] jk_addActionHandler:^(NSInteger tag) {
        self.navigationController.navigationBarHidden = !self.navigationController.navigationBarHidden;
    }];
    
    [[self makeRightButton:@"TableView" index:1] jk_addActionHandler:^(NSInteger tag) {
        VSTableViewController *tb = [[VSTableViewController alloc] init];
        [self.navigationController pushViewController:tb animated:YES];
    }];
}


#pragma mark 通用方法

- (void)makeScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 2000);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (UIButton *)makeLeftButton:(NSString *)title index:(NSInteger) idx {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, idx*35, 150, 30);
    btn.left = 0;
    btn.backgroundColor = TITLE_COLOR;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2.0f;
    [self.scrollView addSubview:btn];
    return btn;
}

- (UIButton *)makeRightButton:(NSString *)title index:(NSInteger) idx {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, idx*35, 150, 30);
    btn.right = SCREEN_WIDTH;
    btn.backgroundColor = TITLE_COLOR;
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 2.0f;
    [self.scrollView addSubview:btn];
    return btn;
}

@end
