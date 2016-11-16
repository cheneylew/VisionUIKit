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

DECLARE_KEY(kVSAlertViewTag)

@interface VSAlertView : UIView

+ (void)AlertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)btnTitles
             callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

+ (void)AlertInView:(UIView *)view
              Title:(NSString *)title
            message:(NSString *)message
       buttonTitles:(NSArray *)btnTitles
          callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

@end
