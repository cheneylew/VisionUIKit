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
