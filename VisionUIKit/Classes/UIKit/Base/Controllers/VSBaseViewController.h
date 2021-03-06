//
//  VSBaseViewController.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/3.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 对NavigationBar/NavigationItem/状态栏 进行自定义。 有默认样式，重写下面方法实现自定义。
 结合JTNavigationController，可灵活定制每一页的NavigationBar
 */
@interface VSBaseViewController : UIViewController

// Navigation Bar
- (UIColor *)vs_navigationBarBackgroundColor;
- (UIColor *)vs_navigationBarHairLineColor;
- (UIColor *)vs_navigationBarTitleColor;
- (UIFont *)vs_navigationBarTitleFont;
- (BOOL)vs_navigationBarHidden;
- (void)vs_decorateNavigationBar:(UINavigationBar *) navigationBar;

// Navigation Items
- (UIColor *)vs_navigationBarBackItemColor;
- (UIImage *)vs_navigationBarBackItemImage;
- (UIImageRenderingMode)vs_navigationBarBackItemImageRenderMode;            //默认UIImageRenderingModeAlwaysTemplate，忽略图片默认颜色

- (UIColor *)vs_navigationBarRightItemColor;
- (NSArray<NSString *> *)vs_navigationBarRightItemsTitles;
- (NSArray<UIImage *> *)vs_navigationBarRightItemsImages;
- (UIImageRenderingMode)vs_navigationBarRightItemsImagesRenderMode;         //默认UIImageRenderingModeAlwaysTemplate，忽略图片默认颜色

- (void)vs_eventNavigationBarBackItemTouched:(UIBarButtonItem *) item;
- (void)vs_eventNavigationBarRightItemTouched:(UIBarButtonItem *) item;
- (void)vs_eventNavigationBarRightItemTouchedIndex:(NSUInteger) index;

// Tab Bar Navigation Items
- (UIColor *)vs_tabBarNavigationBarRightItemColor;
- (NSArray<NSString *> *)vs_tabBarNavigationBarRightItemsTitles;
- (NSArray<UIImage *> *)vs_tabBarNavigationBarRightItemsImages;
- (UIImageRenderingMode)vs_tabBarNavigationBarRightItemsImagesRenderMode;       //默认UIImageRenderingModeAlwaysTemplate，忽略图片默认颜色
- (void)vs_eventTabBarNavigationBarRightItemTouched:(UIBarButtonItem *) item;
- (void)vs_eventTabBarNavigationBarRightItemTouchedIndex:(NSUInteger) index;

- (UIColor *)vs_tabBarNavigationBarLeftItemColor;
- (NSArray<NSString *> *)vs_tabBarNavigationBarLeftItemsTitles;
- (NSArray<UIImage *> *)vs_tabBarNavigationBarLeftItemsImages;
- (UIImageRenderingMode)vs_tabBarNavigationBarLeftItemsImagesRenderMode;        //默认UIImageRenderingModeAlwaysTemplate，忽略图片默认颜色
- (void)vs_eventTabBarNavigationBarLeftItemTouched:(UIBarButtonItem *) item;
- (void)vs_eventTabBarNavigationBarLeftItemTouchedIndex:(NSUInteger) index;

// Tab Item
- (BOOL)vs_tabItemHidden;
- (UIImage *)vs_tabItemSelectedImage;
- (UIImage *)vs_tabItemUnselectedImage;
- (UIColor *)vs_tabItemTitleSelectedColor;
- (UIColor *)vs_tabItemTitleUnSelectedColor;
- (double) vs_tabItemTitleOffsetY;
- (double) vs_tabItemTitleOffsetX;
- (NSString *) vs_tabItemBadgeValue;

/**
 首先需要在info.plist设置：
 View controller-based status bar appearance ＝ NO
 
 @return 状态栏风格
 */
- (UIStatusBarStyle)vs_statusBarStyle;

@end
