//
//  NVGlassMainViewController.m
//  NavyUIKit
//
//  Created by Jelly on 6/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import "NVGlassMainViewController.h"
#import "NavyUIKit.h"
#import "UIImage+Category.h"



#define COLOR_HYH_RED                       [UIColor colorWithRed:227.0f/255.0f green:100.0f/255.0f blue:102.0f/255.0f alpha:1.0f]
#define COLOR_HYH_BLUE                      [UIColor colorWithRed:65.0f/255.0f green:155.0f/255.0f blue:240.0f/255.0f alpha:1.0f]


@implementation NVGlassMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [self decorateNavigationBar:self.navigationController.navigationBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void) decorateNavigationBar:(UINavigationBar *)navigationBar {
    //showing white status
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    
    //navigation bar work
    
    
    [self decorateBackButtonNavigationBar:navigationBar];
    [self decorateRightButtonNavigationBar:navigationBar];
    navigationBar.titleTextAttributes = [self getNavigationTitleTextAttributes];
    
    UIColor* colorBackground = [self getNavigationBarBackgroundColor];
    [navigationBar setBackgroundImage:[UIImage imageWithColor:colorBackground] forBarMetrics:UIBarMetricsDefault];
    UIImage* image = [[UIImage alloc] init];
    navigationBar.shadowImage = image;
    
    
    //    UIImage* image = [[UIImage alloc] init];
    //    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    //    navigationBar.shadowImage = image;
    //    [image release];
    
    if (self.tabBarController) {
        self.tabBarController.navigationItem.titleView = nil;
        self.tabBarController.title = [self getNavigationTitle];
    } else {
        self.navigationItem.titleView = nil;
        self.title = [self getNavigationTitle];
    }
}

- (NSDictionary*) getNavigationTitleTextAttributes {
    //    NSShadow *shadow = [[[NSShadow alloc] init] autorelease];
    //    [shadow setShadowOffset:CGSizeMake(1, 1)];
    //    [shadow setShadowColor:[UIColor lightGrayColor]];
    //    [shadow setShadowBlurRadius:1];
    
    UIFont* font = navigationTitleFont();
    
    return @{NSForegroundColorAttributeName:[self getNavigationTitleColor], /*NSShadowAttributeName:shadow,*/ NSFontAttributeName:font};
}

- (void) decorateBackButtonNavigationBar:(UINavigationBar *)navigationBar {
    
    if ([self.navigationController.viewControllers count] > 1) {
        UIImage *btnImage = [[UIImage imageNamed:@"icon_back.png"] imageWithColor:COLOR_HYH_BLUE];
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 60.0f, 40.0f);
        
        [btn.titleLabel setFont:nvNormalFontWithSize(18.0f)];
        [btn setTitle:@"    " forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_HYH_RED forState:UIControlStateNormal];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
        
        [btn setImage:btnImage forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f)];
        
        [btn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIBarButtonItem* backItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = backItem;
        
        
    }
}

- (void) decorateRightButtonNavigationBar:(UINavigationBar *)navigationBar {
    
}

- (void) customedNavigationBar:(UINavigationBar *)navigationBar {
    
}


- (NSString*) getNavigationTitle {
    return @"标题栏";
}

- (UIColor*) getNavigationTitleColor {
    return [UIColor blackColor];
}

- (void) backButtonAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIColor*) getNavigationBarBackgroundColor {
    
    return COLOR_DEFAULT_WHITE;
}


@end
