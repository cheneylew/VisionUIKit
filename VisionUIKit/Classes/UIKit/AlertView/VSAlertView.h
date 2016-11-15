//
//  VSAlertView.h
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/15.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VSAlertViewJKCallBackBlock)(NSInteger buttonIndex);

@interface VSAlertView : UIView

+ (void)AlertWithTitle:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)btnTitles
             callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

@end
