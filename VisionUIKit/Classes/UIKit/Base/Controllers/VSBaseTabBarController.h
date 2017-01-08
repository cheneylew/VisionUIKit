//
//  VSBaseTabBarController.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2017/1/7.
//  Copyright © 2017年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VSBaseTabBarController : UITabBarController
// Tab Bar
- (UIColor *)vs_tabBarBackgroundColor;              //TabBar设置背景色
- (UIColor *)vs_tabBarSelectedBackgroundColor;      //TabBar选中背景色
- (UIColor *)vs_tabBarHairLineBackgroundColor;      //TabBar发丝线颜色
- (BOOL)vs_tabBarTranslucent;                       //TabBar设置透明效果

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
- (NSArray<NSString *> *)vs_navigationBarRightItemsTitles;
- (NSArray<UIImage *> *)vs_navigationBarRightItemsImages;

// Event
- (void)vs_eventNavigationBarBackItemTouched:(UIBarButtonItem *) item;
- (void)vs_eventNavigationBarRightItemTouched:(UIBarButtonItem *) item;
- (void)vs_eventNavigationBarRightItemTouchedIndex:(NSUInteger) index;


/**
 首先需要在info.plist设置：
 View controller-based status bar appearance ＝ NO
 
 @return 状态栏风格
 */
- (UIStatusBarStyle)vs_statusBarStyle;

@end
