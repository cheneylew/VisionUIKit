//
//  VSSheetView.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/17.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSSheetView.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>
#import <JHChainableAnimations/JHChainableAnimations.h>

NSInteger const kVSSheetViewTag = 5858586;

@interface VSSheetView()

@property (nonatomic, weak)     UIView *parentView;         //添加到的目标视图，默认Window
@property (nonatomic, strong)   UIView *maskView;           //背景蒙版
@property (nonatomic, strong)   UIView *dialogView;         //中间弹出框区域
@property (nonatomic, strong)   UIView *customView;         //定制视图，默认为nil

@property (nonatomic, strong)   NSArray *buttonTitles;      //按钮标题
@property (nonatomic, strong)   NSString *cancelTitle;      //取消
@property (nonatomic, copy)     VSSheetViewCallBackBlock callBack;    //完成回调

@end

@implementation VSSheetView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = kVSSheetViewTag;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        UIView *maskView = [[UIView alloc] initWithFrame:frame];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        maskView.layer.opacity = 0.4;
        WEAK_SELF;
        [maskView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself close];
        }];
        self.maskView = maskView;
        [self addSubview:self.maskView];
    }
    return self;
}

- (instancetype)initWithParentView:(UIView *)parentView
                        customView:(UIView *)customView
                       cancelTitle:(NSString *)cancelTitle
                      buttonTitles:(NSArray *)buttonTitles
                         callBlock:(VSSheetViewCallBackBlock)callBack
{
    if (parentView == nil) {
        parentView = [[UIApplication sharedApplication] keyWindow];
    }
    
    VSSheetView *view  = [[VSSheetView alloc] initWithFrame:parentView.bounds];
    view.customView    = customView;
    view.buttonTitles  = buttonTitles;
    view.callBack      = callBack;
    view.parentView    = parentView;
    view.cancelTitle   = cancelTitle;
    [view makeLayout];
    [view show];
    [parentView addSubview:view];
    
    return view;
}

- (void)makeLayout {
    WEAK_SELF;
    BOOL haveButtons = self.buttonTitles.count?YES:NO;
    BOOL haveCanel = self.cancelTitle.length>0?YES:NO;
    BOOL haveCustomView = self.customView?YES:NO;
    
    CGFloat dwidth = SCREEN_WIDTH;
    CGFloat btnHeight = FIT6P(164);
    CGFloat btnWidth = dwidth;
    CGFloat space = FIT6P(22);
    CGFloat dHeight = haveCustomView?self.customView.height:btnHeight * self.buttonTitles.count+space+btnHeight;
    
    UIView *dialogView              = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dwidth, dHeight)];
    dialogView.backgroundColor      = HEX(0xf9f9f9);
    dialogView.center               = self.center;
    dialogView.clipsToBounds        = YES;
    dialogView.autoresizingMask     = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:dialogView];
    self.dialogView = dialogView;
    
    //buttons
    if (haveButtons) {
        NSInteger count = self.buttonTitles.count;
        [self.buttonTitles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat btnY = btnHeight*idx;
            
            NSString *btnTitle = obj;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = idx+1;
            [button setTitle:btnTitle forState:UIControlStateNormal];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            button.frame = CGRectMake(0,
                                      btnY,
                                      btnWidth,
                                      btnHeight);
            button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            [button setBackgroundImage:[UIImage jk_imageWithColor:HEX(0xebebeb)]
                              forState:UIControlStateHighlighted];
            [button setTitleColor:HEX(0x000000)
                         forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button jk_addActionHandler:^(NSInteger tag) {
                weakself.callBack(tag);
                [weakself close];
            }];
            if (idx != count-1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.width, 0.5)];
                line.backgroundColor = HEX(0xd9d9d9);
                line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                line.top = button.height - 0.5;
                [button addSubview:line];
            }
            [dialogView addSubview:button];
        }];
    }
    
    //取消
    if (haveCanel) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 0;
        [button setTitle:self.cancelTitle forState:UIControlStateNormal];
        button.titleLabel.adjustsFontSizeToFitWidth = YES;
        button.frame = CGRectMake(0,
                                  0,
                                  btnWidth,
                                  btnHeight);
        button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [button setBackgroundImage:[UIImage jk_imageWithColor:HEX(0xebebeb)]
                          forState:UIControlStateHighlighted];
        [button setTitleColor:HEX(0x000000)
                     forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button jk_addActionHandler:^(NSInteger tag) {
            weakself.callBack(tag);
            [weakself close];
        }];
        [dialogView addSubview:button];
        button.bottom = dialogView.height;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, button.width, space)];
        line.backgroundColor = HEX(0xf0f0f0);
        line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        line.bottom = button.top;
        [dialogView addSubview:line];
    }
    
    if (haveCustomView) {
        _customView.centerX = dialogView.centerX;
        _customView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        [dialogView addSubview:_customView];
    }
}

- (void)show {
    self.maskView.layer.opacity = 0;
    self.maskView.makeOpacity(0.3).easeOutBack.animate(0.25);
    
    self.dialogView.top = SCREEN_HEIGHT;
    self.dialogView.makeY(SCREEN_HEIGHT-self.dialogView.height).easeOut.animate(0.26);
    
}

- (void)close {
    WEAK_SELF;
    self.maskView.makeOpacity(0).easeOut.animate(0.25);
    self.dialogView.makeY(SCREEN_HEIGHT).easeOut.animate(0.26).animationCompletion = ^(){
        [weakself removeFromSuperview];
    };
}

+ (VSSheetView *)ShowWithbuttonTitles:(NSArray *)titles
                          cancelTitle:(NSString *)cancelTitle
                            callBlock:(VSSheetViewCallBackBlock)callback
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return [[VSSheetView alloc] initWithParentView:window
                                        customView:nil
                                       cancelTitle:cancelTitle
                                      buttonTitles:titles callBlock:callback];
}

+ (VSSheetView *)ShowWithCustomView:(UIView *)customView
                          callBlock:(VSSheetViewCallBackBlock)callback
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return [[VSSheetView alloc] initWithParentView:window
                                        customView:customView
                                       cancelTitle:nil
                                      buttonTitles:nil callBlock:callback];
}

@end
