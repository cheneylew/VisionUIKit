//
//  UIViewController+Exception.h
//  Navy
//
//  Created by Jelly on 7/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIViewController (Exception)

- (UIImage*) nv_imageOfExceptionView;
- (UIImage*) nv_imageOfErrorView;
- (UIImage*) nv_imageOffNetworkView;
- (UIImage*) nv_imageOfNullDataView;

- (NSAttributedString*) nv_titleOfNullDataView;

- (void) nv_showExceptionView;
- (void) nv_showExceptionViewInView:(UIView*)view;
- (void) nv_showErrorView;
- (void) nv_showOffNetworkView;
- (void) nv_showOffNetworkViewInView:(UIView*)view;
- (void) nv_showNullDataView;
- (void) nv_showNullDataViewInView:(UIView*)view;

- (void) nv_hideExceptionView;

/**
 子类重载，触发事件方法
 */
- (void) nv_tryAgainAtExceptionView;                       //重试一次
- (void) nv_reloadAtNullView;                              //
- (void) nv_nullDataViewExtention:(UIView*)exceptionView;



@end
