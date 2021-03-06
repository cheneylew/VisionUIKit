//
//  VSBaseViewController.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/3.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import "VSBaseViewController.h"
#import <KKCategories/KKCategories.h>
#import <DJMacros/DJMacro.h>
#import "UIImage+Bundle.h"

@interface VSBaseViewController ()

@end

@implementation VSBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTabItem];
        [[UIApplication sharedApplication] setStatusBarStyle:[self vs_statusBarStyle]];
        [self.navigationController setNavigationBarHidden:[self vs_navigationBarHidden]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    [self initNavigationItems];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initTabBarNavigationItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)initTabBarNavigationItems {
    if (!self.tabBarController) {
        return;
    }
    // Left items
    NSArray *leftItemTitles = [self vs_tabBarNavigationBarLeftItemsTitles];
    NSArray *leftItemImages = [self vs_tabBarNavigationBarLeftItemsImages];
    if (leftItemTitles.count == 0 && leftItemImages.count == 0) {
        self.tabBarController.navigationItem.leftBarButtonItems = nil;
    }
    
    if ((leftItemTitles.count && !leftItemImages.count)) {
        NSMutableArray *leftItems = [NSMutableArray array];
        [leftItemTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:obj
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(vs_eventTabBarNavigationBarLeftItemTouched:)];
            leftItem.tintColor = [self vs_tabBarNavigationBarLeftItemColor];
            [leftItems addObject:leftItem];
        }];
        self.tabBarController.navigationItem.leftBarButtonItems = leftItems;
    }
    
    if ((leftItemImages.count && !leftItemTitles.count) || (leftItemTitles.count && leftItemImages.count)) {
        NSMutableArray *leftItems = [NSMutableArray array];
        [leftItemImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *image = obj;
            image = [image imageWithRenderingMode:[self vs_tabBarNavigationBarLeftItemsImagesRenderMode]];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(vs_eventTabBarNavigationBarLeftItemTouched:)];
            leftItem.tintColor = [self vs_tabBarNavigationBarLeftItemColor];
            [leftItems addObject:leftItem];
        }];
        self.tabBarController.navigationItem.leftBarButtonItems = leftItems;
    }
    
    // Right items
    NSArray *rightItemTitles = [self vs_tabBarNavigationBarRightItemsTitles];
    NSArray *rightItemImages = [self vs_tabBarNavigationBarRightItemsImages];
    if (rightItemTitles.count == 0 && rightItemImages.count == 0) {
        self.tabBarController.navigationItem.rightBarButtonItems = nil;
    }
    
    if ((rightItemTitles.count && !rightItemImages.count)) {
        NSMutableArray *rightItems = [NSMutableArray array];
        [rightItemTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:obj
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(vs_eventTabBarNavigationBarRightItemTouched:)];
            rightItem.tintColor = [self vs_tabBarNavigationBarRightItemColor];
            [rightItems addObject:rightItem];
        }];
        self.tabBarController.navigationItem.rightBarButtonItems = rightItems;
    }
    
    if ((rightItemImages.count && !rightItemTitles.count) || (rightItemTitles.count && rightItemImages.count)) {
        NSMutableArray *rightItems = [NSMutableArray array];
        [rightItemImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIImage *image = obj;
            image = [image imageWithRenderingMode:[self vs_tabBarNavigationBarRightItemsImagesRenderMode]];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(vs_eventTabBarNavigationBarRightItemTouched:)];
            rightItem.tintColor = [self vs_tabBarNavigationBarRightItemColor];
            [rightItems addObject:rightItem];
        }];
        self.tabBarController.navigationItem.rightBarButtonItems = rightItems;
    }
}

- (void)initNavigationItems {
    // Back buttons
    UIImage *image = [self vs_navigationBarBackItemImage];
    image = [image imageWithRenderingMode:[self vs_navigationBarBackItemImageRenderMode]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(vs_eventNavigationBarBackItemTouched:)];
    backItem.tintColor = [self vs_navigationBarBackItemColor];
    backItem.imageInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    NSArray *controllers = self.navigationController.viewControllers;
    //JTWrapNavigationController每页都是独立的，navigationController.viewControllers中只有1个
    if ([self.navigationController isKindOfClass:[NSClassFromString(@"JTWrapNavigationController") class]]) {
        if (controllers.count >= 1) {
            self.navigationItem.leftBarButtonItem = backItem;
        }
    } else {
        if (controllers.count > 1) {
            self.navigationItem.leftBarButtonItem = backItem;
        }
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
            UIImage *image = obj;
            image = [image imageWithRenderingMode:[self vs_navigationBarRightItemsImagesRenderMode]];
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:image
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

- (UIImageRenderingMode)vs_navigationBarBackItemImageRenderMode {
    return UIImageRenderingModeAlwaysTemplate;
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

- (UIImageRenderingMode)vs_navigationBarRightItemsImagesRenderMode {
    return UIImageRenderingModeAlwaysTemplate;
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
#pragma mark - Tab Bar Navigation Items -
#pragma mark Tab Bar Navigation Items Right
- (UIColor *)vs_tabBarNavigationBarRightItemColor {
    return [UIColor whiteColor];
}

- (NSArray<NSString *> *)vs_tabBarNavigationBarRightItemsTitles {
    return @[];
}

- (NSArray<UIImage *> *)vs_tabBarNavigationBarRightItemsImages {
    return @[];
}

- (UIImageRenderingMode)vs_tabBarNavigationBarRightItemsImagesRenderMode {
    return UIImageRenderingModeAlwaysTemplate;
}

- (void)vs_eventTabBarNavigationBarRightItemTouched:(UIBarButtonItem *) item {
    NSInteger idx = [self.navigationItem.rightBarButtonItems indexOfObject:item];
    [self vs_eventTabBarNavigationBarRightItemTouchedIndex:idx];
}

- (void)vs_eventTabBarNavigationBarRightItemTouchedIndex:(NSUInteger)index {
    
}

#pragma mark Tab Bar Navigation Items Left
- (UIColor *)vs_tabBarNavigationBarLeftItemColor {
    return [UIColor whiteColor];
}

- (NSArray<NSString *> *)vs_tabBarNavigationBarLeftItemsTitles {
    return @[];
}

- (NSArray<UIImage *> *)vs_tabBarNavigationBarLeftItemsImages {
    return @[];
}

- (UIImageRenderingMode)vs_tabBarNavigationBarLeftItemsImagesRenderMode {
    return UIImageRenderingModeAlwaysTemplate;
}

- (void)vs_eventTabBarNavigationBarLeftItemTouched:(UIBarButtonItem *) item {
    NSInteger idx = [self.navigationItem.leftBarButtonItems indexOfObject:item];
    [self vs_eventTabBarNavigationBarLeftItemTouchedIndex:idx];
}

- (void)vs_eventTabBarNavigationBarLeftItemTouchedIndex:(NSUInteger)index {
    
}

#pragma mark Status Bar Color
- (UIStatusBarStyle)vs_statusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark Tab Item
- (void) initTabItem {
    if (![self vs_tabItemHidden]) {
        UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:[self vs_tabItemTitle]
                                                                 image:[[self vs_tabItemUnselectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                         selectedImage:[[self vs_tabItemSelectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem setTitleTextAttributes:@{ATT_TEXT_COLOR:[self vs_tabItemTitleSelectedColor]}
                                  forState:UIControlStateSelected];
        [tabBarItem setTitleTextAttributes:@{ATT_TEXT_COLOR:[self vs_tabItemTitleUnSelectedColor]}
                                  forState:UIControlStateNormal];
        tabBarItem.titlePositionAdjustment = UIOffsetMake([self vs_tabItemTitleOffsetX], [self vs_tabItemTitleOffsetY]);
        tabBarItem.badgeValue = [self vs_tabItemBadgeValue];
        self.tabBarItem = tabBarItem;
    }

}

- (BOOL) vs_tabItemHidden {
    return YES;
}

- (NSString *) vs_tabItemTitle {
    return @"默认";
}

- (UIImage *) vs_tabItemSelectedImage {
    UIImage *image = [UIImage vs_imageName:@"vs_camera_hl"];
    return image;
}

- (UIImage *) vs_tabItemUnselectedImage {
    UIImage *image = [UIImage vs_imageName:@"vs_camera_ok"];
    return image;
}

- (UIColor *) vs_tabItemTitleSelectedColor {
    return [UIColor blueColor];
}

- (UIColor *) vs_tabItemTitleUnSelectedColor {
    return [UIColor grayColor];
}

- (NSString *) vs_tabItemBadgeValue {
    return nil;
}

- (double) vs_tabItemTitleOffsetY {
    return 0;
}

- (double) vs_tabItemTitleOffsetX {
    return -2;
}


@end
