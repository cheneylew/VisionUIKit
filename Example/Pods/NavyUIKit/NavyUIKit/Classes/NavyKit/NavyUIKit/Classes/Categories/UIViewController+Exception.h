//
//  UIViewController+Exception.h
//  Navy
//
//  Created by Jelly on 7/17/15.
//  Copyright (c) 2015 Steven.Lin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UIViewController (Exception)

/*
 function
 brief       显示异常页面
 return     <#return#>
 */
- (void) showExceptionView;
- (void) showExceptionViewInView:(UIView*)view;

/*
 function
 brief       显示错误页面
 return     <#return#>
 */
- (void) showErrorView;

/*
 function
 brief       显示断网异常页面
 return     <#return#>
 */
- (void) showOffNetworkView;
- (void) showOffNetworkViewInView:(UIView*)view;


- (void) showNullDataView;
- (void) showNullDataViewInView:(UIView*)view;

- (void) hideExceptionView;


- (void) tryAgainAtExceptionView;
- (void) reloadAtNullView;


- (UIImage*) imageOfExceptionView;
- (UIImage*) imageOfErrorView;
- (UIImage*) imageOffNetworkView;
- (UIImage*) imageOfNullDataView;

//- (NSString*) titleOfNullDataView;
- (NSAttributedString*) titleOfNullDataView;
- (void) nullDataViewExtention:(UIView*)exceptionView;

@end
