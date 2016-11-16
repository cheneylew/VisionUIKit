//
//  VSAlertView.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/15.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSAlertView.h"
#import <KKCategories/KKCategories.h>

#define VSSCREEN_SIZE [[UIScreen mainScreen] bounds]
#define VSSCREEN_WIDTH VSSCREEN_SIZE.size.width
#define VSSCREEN_HEIGHT VSSCREEN_SIZE.size.height

#define kFit5(x) ((x)/640.0f)*VSSCREEN_WIDTH
#define kFit6(x) ((x)/750.0f)*VSSCREEN_WIDTH
#define kFit6p(x) ((x)/1242.0f)*VSSCREEN_WIDTH
#define kFit1024(x) ((x)/1024.0f)*VSSCREEN_WIDTH
#define kFitRect6(x,y,w,h) CGRectMake(fit6(x), fit6(y), fit6(w), fit6(h))
#define kFitRect1024(x,y,w,h) CGRectMake(fit1024(x), fit1024(y), fit1024(w), fit1024(h))

NSInteger const kVSAlertViewTag = 5858585;

@interface VSAlertView()

@property (nonatomic, weak) UIView *parentView; //添加到的目标视图，默认Window
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *dialogView;
@property (nonatomic, strong) UIView *buttonsView;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *buttonTitles;

@property (nonatomic, copy) VSAlertViewJKCallBackBlock callBack;

@end

@implementation VSAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = kVSAlertViewTag;
        
        UIView *maskView = [[UIView alloc] initWithFrame:frame];
        maskView.backgroundColor = [UIColor lightGrayColor];
        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        maskView.layer.opacity = 0.2;
        self.maskView = maskView;
        [self addSubview:self.maskView];
    }
    return self;
}

- (void)makeLayout {
    CGFloat topBottomSpace = kFit6(44);
    CGFloat leftRightSpace = kFit6(34);
    
    UIFont *msgFont = [UIFont systemFontOfSize:14];
    
    CGFloat dWidth = kFit6(545);
    CGFloat mWidth = dWidth - 2*leftRightSpace;
    CGFloat mHeight = [self.message jk_heightWithFont:msgFont constrainedToWidth:mWidth];
    
    CGFloat btnHeight = kFit6(90);
    if (mHeight < 50) {
        mHeight = 50;
    }
    CGFloat dHeight = topBottomSpace*2+mHeight+btnHeight;
    
    UIView *dialogView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
    dialogView.backgroundColor = [UIColor whiteColor];
    dialogView.layer.cornerRadius = 6.0f;
    dialogView.center = self.center;
    [self addSubview:dialogView];
    self.dialogView = dialogView;

    
    //buttons
    NSInteger count = self.buttonTitles.count;
    if (count) {
        CGFloat btnWidth = dWidth/self.buttonTitles.count;
        CGFloat btnY = dHeight-btnHeight;
        [self.buttonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *btnTitle = obj;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = idx;
            [button setTitle:btnTitle forState:UIControlStateNormal];
            [button addTarget:self
                       action:@selector(btnClick:)
             forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(btnWidth*idx,
                                      btnY,
                                      btnWidth,
                                      btnHeight);
            button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            if (idx != count-1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(btnWidth, 0, 0.5, btnHeight)];
                line.backgroundColor = [UIColor colorWithRed:207/255.0f green:215/255.0f blue:223/255.0f alpha:1];
                line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                [button addSubview:line];
            }
            [dialogView addSubview:button];
        }];
        
        // add button top line
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btnY, dWidth, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:207/255.0f green:215/255.0f blue:223/255.0f alpha:1];
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [dialogView addSubview:line];
    }
    
    //message label
    if (self.message.length) {
        UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftRightSpace, topBottomSpace, mWidth, mHeight)];
        msgLabel.text = self.message;
        msgLabel.font = msgFont;
        msgLabel.numberOfLines = 0;
        [dialogView addSubview:msgLabel];
    }
}

- (void)btnClick:(UIButton *)button {
    if (self.callBack) {
        self.callBack(button.tag);
        [UIView animateWithDuration:0.35 animations:^{
            self.layer.opacity = 0.2;
            [self closeAlertView];
        }];
    }
}

- (void)closeAlertView {
    [self removeFromSuperview];
}

- (void)dealloc {
    NSLog(@"VSAlertView 销毁了");
}

+ (void)AlertWithTitle:(NSString *)title
                message:(NSString *)message
           buttonTitles:(NSArray *)btnTitles
              callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    VSAlertView *alertView = [[VSAlertView alloc] initWithFrame:bounds];
    alertView.title = title;
    alertView.message = message;
    alertView.buttonTitles = btnTitles;
    alertView.callBack = alertViewCallBackBlock;
    alertView.parentView = keyWindow;
    [alertView makeLayout];
    [keyWindow addSubview:alertView];
}

+ (void)AlertInView:(UIView *)view
              Title:(NSString *)title
               message:(NSString *)message
          buttonTitles:(NSArray *)btnTitles
             callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    VSAlertView *alertView = [[VSAlertView alloc] initWithFrame:bounds];
    alertView.title = title;
    alertView.message = message;
    alertView.buttonTitles = btnTitles;
    alertView.callBack = alertViewCallBackBlock;
    alertView.parentView = view;
    [alertView makeLayout];
    [view addSubview:alertView];
}

@end
