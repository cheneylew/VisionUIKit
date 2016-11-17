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


/**
 定制AlertView更灵活：
 可设置标题/消息的对齐方式
 增加关闭按钮
 可设置自定义视图来弹出
 */
@interface VSAlertView : UIView

@property (nonatomic, assign) NSTextAlignment titleTextAlignment;
@property (nonatomic, assign) NSTextAlignment messageTextAlignment;

- (void)showCloseButton:(BOOL)isShow;

+ (VSAlertView *)ShowWithTitle:(NSString *)title
                       message:(NSString *)message
                  buttonTitles:(NSArray *)btnTitles
                     callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

+ (VSAlertView *)ShowInView:(UIView *)view
                      Title:(NSString *)title
                    message:(NSString *)message
               buttonTitles:(NSArray *)btnTitles
                  callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

+ (VSAlertView *)ShowInView:(UIView *)view
                 customView:(UIView *)customView
               buttonTitles:(NSArray *)btnTitles
                  callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock;

@end
