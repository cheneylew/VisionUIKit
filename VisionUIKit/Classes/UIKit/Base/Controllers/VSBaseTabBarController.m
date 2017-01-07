//
//  VSBaseTabBarController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/7.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSBaseTabBarController.h"
#import <KKCategories/KKCategories.h>
#import <DJMacros/DJMacro.h>
#import "UIImage+Bundle.h"
#import <ReactiveCocoa/NSObject+RACPropertySubscribing.h>
#import <ReactiveCocoa/RACSignal.h>

@interface VSBaseTabBarController ()

@property (nonatomic, strong) RACDisposable *rac;

@end

@implementation VSBaseTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        WEAK_SELF;
        self.selectedIndex = 0;
        self.rac = [RACObserve(self, selectedViewController) subscribeNext:^(UIViewController* controller) {
            STRONG(weakself);
            strongweakself.title = controller.title;
        }];
        
//        UIView* backView = [[UIView alloc]init];
//        backView.backgroundColor = HEX(0x787fb5);
//        backView.frame = self.tabBar.bounds;
//        backView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//        [[UITabBar appearance] insertSubview:backView atIndex:0];
        
        [[UITabBar appearance] setBackgroundImage:[UIImage jk_imageWithColor:[self vs_tabBarBackgroundColor]]];
        [UITabBar appearance].translucent = [self vs_tabBarTranslucent];  //禁用透明效果
    }
    return self;
}

- (UIColor *)vs_tabBarBackgroundColor {
    return HEXA(0xefefef,0.8);
}

- (BOOL)vs_tabBarTranslucent {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initNavigationBar];
    [self initNavigationItems];
    [[UIApplication sharedApplication] setStatusBarStyle:[self vs_statusBarStyle]];
    [self.navigationController setNavigationBarHidden:[self vs_navigationBarHidden]];
}

- (void)initNavigationBar {
    //背景色透明
    [self.navigationController.navigationBar setBackgroundImage:[UIImage jk_imageWithColor:[self vs_navigationBarBackgroundColor]]
                                                  forBarMetrics:UIBarMetricsDefault];
    //发丝线透明
    [self.navigationController.navigationBar setShadowImage:[UIImage jk_imageWithColor:[self vs_navigationBarHairLineColor]]];
    
    //标题样式
    [self.navigationController.navigationBar setTitleTextAttributes:@{ATT_TEXT_COLOR:[self vs_navigationBarTitleColor],
                                                                      ATT_FONT:[self vs_navigationBarTitleFont]
                                                                      }];
    [self vs_decorateNavigationBar:self.navigationController.navigationBar];
}

- (void)vs_decorateNavigationBar:(UINavigationBar *) navigationBar {
    
}

- (void)initNavigationItems {
    // Back buttons
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[self vs_navigationBarBackItemImage]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(vs_eventNavigationBarBackItemTouched:)];
    backItem.tintColor = [self vs_navigationBarBackItemColor];
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    // Right items
    NSArray *rightItemTitles = [self vs_navigationBarRightItemsTitles];
    NSArray *rightItemImages = [self vs_navigationBarRightItemsImages];
    if ((rightItemTitles.count && !rightItemImages.count)) {
        NSMutableArray *rightItems = [NSMutableArray array];
        [rightItemTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:obj
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(vs_eventNavigationBarRightItemTouched:)];
            rightItem.tintColor = [self vs_navigationBarRightItemColor];
            [rightItems addObject:rightItem];
        }];
        self.navigationItem.rightBarButtonItems = rightItems;
    }
    
    if ((rightItemImages.count && !rightItemTitles.count) || (rightItemTitles.count && rightItemImages.count)) {
        NSMutableArray *rightItems = [NSMutableArray array];
        [rightItemImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:obj
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(vs_eventNavigationBarRightItemTouched:)];
            rightItem.tintColor = [self vs_navigationBarRightItemColor];
            [rightItems addObject:rightItem];
        }];
        self.navigationItem.rightBarButtonItems = rightItems;
    }
}

#pragma mark Navigation Bar

- (UIColor *)vs_navigationBarBackgroundColor {
    return HEX(0x262a30);
}

- (UIColor *)vs_navigationBarHairLineColor {
    return [UIColor clearColor];
}

- (UIColor *)vs_navigationBarTitleColor {
    return [UIColor whiteColor];
}

- (UIFont *)vs_navigationBarTitleFont {
    return [UIFont systemFontOfSize:17];
}

- (BOOL)vs_navigationBarHidden {
    return NO;
}

#pragma mark Navigation Items
- (UIColor *)vs_navigationBarBackItemColor {
    return [UIColor whiteColor];
}

- (UIImage *)vs_navigationBarBackItemImage {
    return [UIImage vs_imageName:@"vs_navigation_back_normal"];
}

- (UIColor *)vs_navigationBarRightItemColor {
    return [UIColor whiteColor];
}

- (NSArray<NSString *> *)vs_navigationBarRightItemsTitles {
    return @[];
}

- (NSArray<UIImage *> *)vs_navigationBarRightItemsImages {
    return @[];
}

- (void)vs_eventNavigationBarBackItemTouched:(UIBarButtonItem *) item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)vs_eventNavigationBarRightItemTouched:(UIBarButtonItem *) item {
    NSInteger idx = [self.navigationItem.rightBarButtonItems indexOfObject:item];
    [self vs_eventNavigationBarRightItemTouchedIndex:idx];
}

- (void)vs_eventNavigationBarRightItemTouchedIndex:(NSUInteger)index {
    
}

#pragma mark Status Bar Color
- (UIStatusBarStyle)vs_statusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
