//
//  VSAlertView.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/15.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSAlertView.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>
#import <JHChainableAnimations/JHChainableAnimations.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

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

@property (nonatomic, weak)     UIView *parentView;         //添加到的目标视图，默认Window
@property (nonatomic, strong)   UIView *maskView;           //背景蒙版
@property (nonatomic, strong)   UIView *dialogView;         //中间弹出框区域
@property (nonatomic, strong)   UIView *buttonsView;        //底部按钮区域
@property (nonatomic, strong)   UIView *customView;         //定制视图，默认为nil

@property (nonatomic, strong)   NSString *title;            //标题
@property (nonatomic, strong)   id      message;            //消息内容，可能是NSAttributeString或NSString
@property (nonatomic, strong)   NSArray *buttonTitles;      //按钮标题

@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *messageLabel;

@property (nonatomic, strong)   UIButton *closeButton;

@property (nonatomic, copy)     VSAlertViewJKCallBackBlock callBack;    //完成回调

@end

@implementation VSAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = kVSAlertViewTag;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        UIView *maskView = [[UIView alloc] initWithFrame:frame];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        maskView.layer.opacity = 0.4;
        self.maskView = maskView;
        [self addSubview:self.maskView];
    }
    return self;
}

- (instancetype)initWithParentView:(UIView *)parentView
                        customView:(UIView *)customView
                             Title:(NSString *)title
                           message:(id)message
                      buttonTitles:(NSArray *)buttonTitles
                         callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock
{
    if (parentView == nil) {
        parentView = [[UIApplication sharedApplication] keyWindow];
    }
    
    VSAlertView *alertView  = [[VSAlertView alloc] initWithFrame:parentView.bounds];
    alertView.customView    = customView;
    alertView.title         = title;
    alertView.message       = message;
    alertView.buttonTitles  = buttonTitles;
    alertView.callBack      = alertViewCallBackBlock;
    alertView.parentView    = parentView;
    [alertView makeLayout];
    [alertView showAlertView];
    [parentView addSubview:alertView];
    
    return alertView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.closeButton.centerX = self.dialogView.right;
    self.closeButton.centerY = self.dialogView.top;
}

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, kFit6(60), kFit6(60));
        btn.layer.cornerRadius = btn.height/2;
        btn.clipsToBounds = YES;
        btn.hidden = YES;
        [btn setTitle:@"X" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage jk_imageWithColor:HEX(0xaaaaaa)]
                       forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage jk_imageWithColor:HEX(0xbbbbbb)]
                       forState:UIControlStateHighlighted];
        _closeButton = btn;
        
        WEAK_SELF;
        [btn jk_addActionHandler:^(NSInteger tag) {
            [weakself closeAlertView];
        }];
        
        [self addSubview:_closeButton];
    }
    return _closeButton;
}

- (void)makeLayout {
    BOOL haveTitle = self.title.length>0?YES:NO;
    BOOL haveCustomView = self.customView!=nil?YES:NO;
    BOOL haveButtons = self.buttonTitles.count;
    
    CGFloat topBottomSpace = haveButtons?kFit6(44):kFit6(30);
    CGFloat leftRightSpace = haveButtons?kFit6(34):topBottomSpace;
    CGFloat titleAndMessageSpace = haveTitle?kFit6(30):0;
    
    UIFont *messageFont = [UIFont systemFontOfSize:16];
    UIFont *titleFont = [UIFont systemFontOfSize:17];
    
    CGFloat dWidth = haveCustomView?leftRightSpace+self.customView.width+leftRightSpace:kFit6(600);
    
    CGFloat mWidth = dWidth - 2*leftRightSpace;
    CGFloat mHeight = 0.0f;
    if ([self.message isKindOfClass:[NSAttributedString class]]) {
        mHeight = [self.message boundingRectWithSize:CGSizeMake(mWidth, 1000000.0f)
                                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                        context:nil].size.height;
    }else {
        mHeight = [self.message jk_heightWithFont:messageFont constrainedToWidth:mWidth];
    }
    
    CGFloat tWidth  = mWidth;
    CGFloat tHeight = haveTitle?[self.title jk_heightWithFont:titleFont constrainedToWidth:tWidth]:0;
    
    
    CGFloat btnHeight = kFit6(90);
    if (mHeight < 50) {
        mHeight = 50;
    }
    btnHeight = haveButtons?btnHeight:0;
    
    //dHeight = 上边距+标题高度+标题与内容边距+内容高度+内容下边距+按钮高度
    CGFloat dHeight = topBottomSpace+tHeight+titleAndMessageSpace+mHeight+topBottomSpace+btnHeight;
    dHeight = haveCustomView?topBottomSpace+self.customView.height+topBottomSpace+btnHeight:dHeight;
    
    UIView *dialogView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dWidth, dHeight)];
    dialogView.backgroundColor      = HEX(0xf9f9f9);
    dialogView.layer.cornerRadius   = 6.0f;
    dialogView.center               = self.center;
    dialogView.clipsToBounds        = YES;
    dialogView.autoresizingMask     =   UIViewAutoresizingFlexibleLeftMargin|
                                    UIViewAutoresizingFlexibleRightMargin|
                                    UIViewAutoresizingFlexibleTopMargin|
                                    UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:dialogView];
    self.dialogView = dialogView;
    
    //标题
    if (haveTitle) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftRightSpace,
                                                                        topBottomSpace,
                                                                        tWidth,
                                                                        tHeight)];
        titleLabel.text = self.title;
        titleLabel.font = titleFont;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [dialogView addSubview:titleLabel];
        
        self.titleLabel = titleLabel;
    }
    
    //消息
    if (!haveCustomView) {
        CGFloat top = topBottomSpace+tHeight+titleAndMessageSpace;
        if (!haveTitle) {
            top = topBottomSpace;
        }
        UILabel *msgLabel = nil;
        if ([self.message isKindOfClass:[NSAttributedString class]]) {
            msgLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(leftRightSpace,
                                                                 top,
                                                                 mWidth,
                                                                 mHeight)];
            msgLabel.attributedText = self.message;
        } else {
            msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftRightSpace,
                                                                            top,
                                                                            mWidth,
                                                                            mHeight)];
            msgLabel.text = self.message;
        }
        msgLabel.font = messageFont;
        msgLabel.numberOfLines = 0;
        msgLabel.textAlignment = NSTextAlignmentCenter;
        [dialogView addSubview:msgLabel];
        
        self.messageLabel = msgLabel;
    }else {
        self.customView.top = topBottomSpace;
        self.customView.left = leftRightSpace;
        [dialogView addSubview:self.customView];
    }
    
    //buttons
    NSInteger count = self.buttonTitles.count;
    if (count) {
        CGFloat btnWidth = dWidth/self.buttonTitles.count;
        CGFloat btnY = dHeight-btnHeight;
        [self.buttonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *btnTitle = obj;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = idx;
            [button setTitle:btnTitle forState:UIControlStateNormal];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            [button addTarget:self
                       action:@selector(btnClick:)
             forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(btnWidth*idx,
                                      btnY,
                                      btnWidth,
                                      btnHeight);
            button.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            [button setBackgroundImage:[UIImage jk_imageWithColor:HEX(0xebebeb)]
                              forState:UIControlStateHighlighted];
            [button setTitleColor:HEX(0x007aff)
                         forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
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
    
    // 关闭按钮
    if (!haveButtons) {
        self.closeButton.hidden = NO;
    }
}

- (void)btnClick:(UIButton *)button {
    if (self.callBack) {
        self.callBack(button.tag);
        [self closeAlertView];
    }
}

- (void)showAlertView {
    WEAK_SELF;
    self.maskView.layer.opacity = 0;
    self.dialogView.hidden = YES;
    self.dialogView.transformScale(0.2).animate(0.01).animationCompletion = ^(){
        weakself.dialogView.hidden = NO;
        weakself.dialogView.transformScale(5).easeOutBack.animate(0.26);
    };
    self.maskView.makeOpacity(0.4).easeOutBack.animate(0.25);
    
}

- (void)closeAlertView {
    WEAK_SELF;
    self.closeButton.hidden = YES;
    self.maskView.makeOpacity(0).easeOut.animate(0.25);
    self.dialogView.transformScale(0.2).makeOpacity(0).easeInBack.animate(0.25).animationCompletion = ^() {
        [weakself removeFromSuperview];
    };
}

- (void)showCloseButton:(BOOL)isShow {
    self.closeButton.hidden = !isShow;
    if (isShow) {
        self.closeButton.layer.opacity = 0;
        self.closeButton.makeOpacity(1).animate(0.26);
    }else {
        self.closeButton.layer.opacity = 1;
        self.closeButton.makeOpacity(0).animate(0.26);
    }
}

- (void)enableTapMaskClose:(BOOL)enabled {
    if (enabled) {
        self.maskView.userInteractionEnabled = YES;
        WEAK_SELF;
        [self.maskView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself closeAlertView];
        }];
    }else {
        self.maskView.userInteractionEnabled = NO;
    }
}

- (void)dealloc {
    NSLog(@"VSAlertView 销毁了");
}

- (void)setTitleTextAlignment:(NSTextAlignment)titleTextAlignment {
    if (self.titleLabel) {
        self.titleLabel.textAlignment = titleTextAlignment;
    }
}

- (void)setMessageTextAlignment:(NSTextAlignment)messageTextAlignment {
    if (self.messageLabel) {
        self.messageLabel.textAlignment = messageTextAlignment;
    }
}

+ (VSAlertView *)ShowWithTitle:(NSString *)title
                       message:(id)message
                  buttonTitles:(NSArray *)btnTitles
                     callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock {
    
    return [[VSAlertView alloc] initWithParentView:[[UIApplication sharedApplication] keyWindow]
                                        customView:nil
                                             Title:title
                                           message:message
                                      buttonTitles:btnTitles
                                         callBlock:alertViewCallBackBlock];
}

+ (VSAlertView *)ShowInView:(UIView *)view
                      Title:(NSString *)title
                    message:(id)message
               buttonTitles:(NSArray *)btnTitles
                  callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock {
    return [[VSAlertView alloc] initWithParentView:view
                                        customView:nil
                                             Title:title message:message
                                      buttonTitles:btnTitles
                                         callBlock:alertViewCallBackBlock];
}

+ (VSAlertView *)ShowInView:(UIView *)view
                 customView:(UIView *)customView
               buttonTitles:(NSArray *)btnTitles
                  callBlock:(VSAlertViewJKCallBackBlock)alertViewCallBackBlock {
    return [[VSAlertView alloc] initWithParentView:view
                                        customView:customView
                                             Title:@""
                                           message:@""
                                      buttonTitles:btnTitles
                                         callBlock:alertViewCallBackBlock];
}

@end
