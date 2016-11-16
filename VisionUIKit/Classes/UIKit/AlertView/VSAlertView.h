//
//  VSAlertView.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/15.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DJMacros/DJMacro.h>

typedef void(^VSAlertViewJKCallBackBlock)(NSInteger buttonIndex);

FOUNDATION_EXPORT NSInteger const kVSAlertViewTag;

@interface VSAlertView : UIView

@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;

- (void)showCloseButton:(BOOL)isShow;

+ (VSAlertView *)ShowAlertViewTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)btnTitles
             callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

+ (VSAlertView *)ShowAlertViewInView:(UIView *)view
              Title:(NSString *)title
            message:(NSString *)message
       buttonTitles:(NSArray *)btnTitles
          callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

+ (VSAlertView *)ShowAlertViewInView:(UIView *)view
                          customView:(UIView *)customView
                        buttonTitles:(NSArray *)btnTitles
                           callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

@end
