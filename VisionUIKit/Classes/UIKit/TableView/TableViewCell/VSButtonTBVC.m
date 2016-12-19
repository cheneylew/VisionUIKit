//
//  VSButtonTBVC.m
//  VisionUIKit
//
//  Created by Dejun Liu on 2016/11/27.
//  Copyright © 2016年 Deju Liu. All rights reserved.
//

#import "VSButtonTBVC.h"
#import <DJMacros/DJMacro.h>
#import <KKCategories/KKCategories.h>

#define VSButtonTBVC_BUTTON_COLOR_NORMAL      RGB(23, 140, 242)
#define VSButtonTBVC_BUTTON_COLOR_HIGHTLIGHT  RGB(30, 182, 239)
#define VSButtonTBVC_BUTTON_TITLE_COLOR       [UIColor whiteColor]
#define VSButtonTBVC_BUTTON_TITLE_FONT        [UIFont systemFontOfSize:15]

@implementation VSTBButtonDataModel



@end

@interface VSButtonTBVC()

@property (nonatomic, strong) UIButton *button;

@end

@implementation VSButtonTBVC


- (void)initUI {
    [super initUI];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.7, 30);
    btn.layer.cornerRadius = 3.0f;
    btn.clipsToBounds = YES;
    btn.titleLabel.font = VSButtonTBVC_BUTTON_TITLE_FONT;
    [btn setBackgroundImage:[UIImage jk_imageWithColor:VSButtonTBVC_BUTTON_COLOR_NORMAL]
                   forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage jk_imageWithColor:VSButtonTBVC_BUTTON_COLOR_HIGHTLIGHT]
                   forState:UIControlStateHighlighted];
    [btn setTitle:@"登陆" forState:UIControlStateNormal];
    [btn setTitleColor:VSButtonTBVC_BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    WEAK_SELF;
    [btn jk_addActionHandler:^(NSInteger tag) {
        if ([weakself.delegate respondsToSelector:@selector(VSButtonTBVCWithButtonClickEvent:model:)]) {
            [weakself.delegate VSButtonTBVCWithButtonClickEvent:weakself.button
                                                            model:weakself.cellModel];
        }
    }];
    [self addSubview:btn];
    self.button = btn;
}

- (void)setModel:(VSTBButtonDataModel *)cellModel {
    [super setModel:cellModel];
    self.delegate = (id<VSButtonTBVCDelegate> )cellModel.controller;
    
    self.button.height = 40.0f;
    self.button.centerY = cellModel.height.floatValue/2.0f;
    self.button.centerX = SCREEN_WIDTH/2.0f;
    
    if (cellModel.button_normal_color) {
        [self.button setBackgroundImage:[UIImage jk_imageWithColor:cellModel.button_normal_color]
                       forState:UIControlStateNormal];
    }else {
        [self.button setBackgroundImage:[UIImage jk_imageWithColor:VSButtonTBVC_BUTTON_COLOR_NORMAL]
                       forState:UIControlStateNormal];
    }
    
    if (cellModel.button_hightlight_color) {
        [self.button setBackgroundImage:[UIImage jk_imageWithColor:cellModel.button_hightlight_color]
                               forState:UIControlStateHighlighted];
    }else {
        [self.button setBackgroundImage:[UIImage jk_imageWithColor:VSButtonTBVC_BUTTON_COLOR_HIGHTLIGHT]
                               forState:UIControlStateHighlighted];
    }
    
    if (cellModel.button_title_color) {
        [self.button setTitleColor:cellModel.button_title_color forState:UIControlStateNormal];
    }else {
        [self.button setTitleColor:VSButtonTBVC_BUTTON_TITLE_COLOR forState:UIControlStateNormal];
    }
    
    if (cellModel.button_title_font) {
        self.button.titleLabel.font = cellModel.button_title_font;
    }else {
        self.button.titleLabel.font = VSButtonTBVC_BUTTON_TITLE_FONT;
    }
    
    if (cellModel.button_title) {
        [self.button setTitle:cellModel.button_title forState:UIControlStateNormal];
    }else {
        [self.button setTitle:@"默认标题" forState:UIControlStateNormal];
    }
    
}

@end
